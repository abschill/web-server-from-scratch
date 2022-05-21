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

void sigchld_handler(int s) {
    // waitpid() might overwrite errno, so we save and restore it:
    int saved_errno = errno;
    while(waitpid( -1, NULL, WNOHANG) > 0);
    errno = saved_errno;
}

char* get_home_content() {
  char* buffer; 
  long length;
  // char success[] = "HTTP/1.1 200 OK \r\n";
  // open the index html in read mode
  FILE * f = fopen("index.html", "r");
  if(f) {
    //append success msg before writing the file itself
     
    //strcat(buffer, success);
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
    //strncat(buffer, 
    // seek set moves the pointer to the beginning of the file like we did earlier with SEEK_END
    fseek(f, 0, SEEK_SET);
    // set the buffer for the length of the string
    //strcpy(buffer
    buffer = malloc(length);
    // if it exists read the content into the buffer
    if(buffer) {
      // read file into buffer
      fread(buffer, 1, length, f);
    }
    // close the pointer before returning
    fclose(f);
  }
  // return the buffer as a char* (make sure u free after giving to the client)
  //printf("Content: \n%s\n", buffer);
  //strcat(buffer, "Content Length: 
  return buffer;
}

struct addrinfo  set_hints() {
    struct addrinfo hints;
    
   
    return hints;
}

// get sockaddr, IPv4 or IPv6:
void *get_in_addr(struct sockaddr *sa) {
    if (sa->sa_family == AF_INET) {
      return &(((struct sockaddr_in*)sa)->sin_addr);
    }

    return &(((struct sockaddr_in6*)sa) -> sin6_addr);
}

void ensure_addr(struct addrinfo *a) {
  if (a == NULL)  {
        fprintf(stderr, "server: failed to bind\n");
        exit(1);
   }
}
// convert the http response body into a valid http request with the headers and zlib integration (todo)
//char* msg_to_http(char* msg) {
  
  //}

int main() {
    int sockfd, new_fd;  // listen on sock_fd, new connection on new_fd
    struct addrinfo hints, *servinfo, *p;
    struct sockaddr_storage req_addr; // request address 
    socklen_t sin_size;
    struct sigaction sa;
    int yes=1;
    char s[INET6_ADDRSTRLEN];
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
        if ((sockfd = socket(p-> ai_family, p-> ai_socktype,
                p-> ai_protocol)) == -1) {
            perror("server: socket");
            continue;
        }

        if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &yes,
                sizeof(int)) == -1) {
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

    freeaddrinfo(servinfo); // all done with this structure

    //ensure_addr(p);
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
	//send(new_fd, content, 500, 0);
        if (!fork()) { // this is the child process
            close(sockfd); // child doesn't need the listener
	    //char* content = get_home_content();
	    //char* content_200 = create_200_content(raw_content);
	    //char* response_data;
	    //strcat("HTTP/1.1 200 OK\r\n", content);
	    //	    sprintf("%s\n", content);
	   
	    // printf("Content Size: %ld\n", sizeof content_200);
            if (send(new_fd, content, 1200, 0) == -1)
                perror("send");
            close(new_fd);
	    free(content);
            exit(0);
        }
        close(new_fd);  // parent doesn't need this
	//free(content);
    }

    return 0;
}
