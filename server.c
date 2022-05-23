#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <sys/wait.h>
#include <signal.h>
#define PORT "3000"  // the port users will be connecting to
#define EOL "\r\n"
#define EOL_SIZE 4
#define BACKLOG 10   // how many pending connections queue will hold
size_t fsize = 580;

void sigchld_handler(int s) {
    // waitpid() might overwrite errno, so we save and restore it:
    int saved_errno = errno;
    while(waitpid( -1, NULL, WNOHANG) > 0);
    errno = saved_errno;
}

char* get_home_content() {
  char* buffer;
  long length;
  FILE * f = fopen("index.html", "r");
  if(f) {
    /**
      fseek sets the file position of the stream to the given offset.
      it starts at the back, so we have to set SEEK_END as the final parameter as the "from" argument
      the middle arg is the # of bytes to be offset from the whence (from) arg
      the first arg is the pointer to the pointer to the stream from fopen
     **/
    fseek(f, 0, SEEK_END);
    /**
     * ftell returns the current file position of the specified stream with respect ot the start of the 	file. this basically gives us the total size after moving the pointer to the end of the file
     **/
    length = ftell(f);
    //set the global response length to the size of the file bc it has the headers
    fsize = (size_t)length;
    // seek set moves the pointer to the beginning of the file like we did earlier with SEEK_END
    fseek(f, 0, SEEK_SET);
    // set the buffer size for the length of the file
    buffer = malloc(length);
    // make sure its pointing to the allocation space (non-null)
    if(buffer) {
      // read file into buffer
      fread(buffer, 1, length, f);
    }
    // close the pointer before returning
    fclose(f);
  }
  // return char* buffer
  return buffer;
}

// get sockaddr, IPv4 or IPv6:
void *get_in_addr(struct sockaddr *sa) {
    if (sa->sa_family == AF_INET) {
      return &(((struct sockaddr_in*)sa)->sin_addr);
    }

    return &(((struct sockaddr_in6*)sa) -> sin6_addr);
}

int main() {
    int sockfd, new_fd;  // listen on sock_fd, new connection on new_fd
    struct addrinfo hints, *servinfo, *p;
    struct sockaddr_storage req_addr; // request address 
    socklen_t sin_size;
    struct sigaction sa;
    char s[INET6_ADDRSTRLEN];
    int y = 1;
    int rv;
    memset(&hints, 0, sizeof hints);
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_flags = AI_PASSIVE; // use my IP
    if ((rv = getaddrinfo(NULL, PORT, &hints, &servinfo)) != 0) {
        fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(rv));
        return 1;
    }

    // loop through all the results and bind to the first we can
    for (p = servinfo; p != NULL; p = p-> ai_next) {
        if ((sockfd = socket(p-> ai_family, p-> ai_socktype, p-> ai_protocol)) == -1) {
            perror("server: socket");
            continue;
        }

        // setsockopt() arg (socket, level, oname, oval, olen)
        // socketfd, protocol specified by level int (SOL_SOCKET means its specified in the stream itself)
        // &1 is the address of the flag to set the "reuse" address option to true
        if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &y, sizeof(int)) == -1) {
            perror("setsockopt");
            exit(1);
        }

        if (bind(sockfd, p-> ai_addr, p-> ai_addrlen) == -1) {
            close(sockfd);
            perror("server: bind");
            continue;
        }
        break;
    }

    freeaddrinfo(servinfo); // all done with this

    if (p == NULL)  {
        fprintf(stderr, "server: failed to bind\n");
        exit(1);
   }
    if (listen(sockfd, BACKLOG) == -1) {
        perror("listen");
        exit(1);
    }
    sa.sa_handler = sigchld_handler; // reap all dead processes
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = SA_RESTART;
    if (sigaction(SIGCHLD, &sa, NULL) == -1) {
        perror("sigaction");
        exit(1);
    }

    printf("http server: waiting for connections on 3000...\n");

    while(1) {  // main accept() loop
        sin_size = sizeof req_addr;
        new_fd = accept(sockfd, (struct sockaddr *)&req_addr, &sin_size);
        if (new_fd == -1) {
            perror("accept");
            continue;
        }

        inet_ntop(req_addr.ss_family,
            get_in_addr((struct sockaddr *)&req_addr),
            s, sizeof s);
        printf("server: got connection from %s\n", s);
	    char* content = get_home_content();
        if (!fork()) { // this is the child process
            close(sockfd); // child doesn't need the listener
            if (send(new_fd, content, fsize, MSG_CONFIRM) == -1)
                    perror("send");
                close(new_fd);
                exit(0);
        }
        free(content);
        close(new_fd);  // close after
	//free(content);
    }

    return 0;
}
