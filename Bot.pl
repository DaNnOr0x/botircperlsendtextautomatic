use strict;
use warnings;
use IO::Socket::INET;

# Configurazioni della connessione IRC
my $server = 'irc.server.com';
my $port = 6667;
my $channel = '#channel_name';
my $nick = 'bot_nick';

# Path del file con il testo da inviare
my $file_path = 'path/to/file.txt';

# Leggi il testo da inviare
open(my $file, '<', $file_path) or die "Impossibile aprire il file $file_path: $!";
my $text = do { local $/; <$file> };
close($file);

# Connessione al server IRC
my $socket = new IO::Socket::INET(
    PeerAddr => $server,
    PeerPort => $port,
    Proto => 'tcp'
) or die "Impossibile connettersi al server IRC: $!";

# Invio dei comandi di autenticazione
print $socket "NICK $nick\r\n";
print $socket "USER $nick 8 * :$nick IRC Bot\r\n";
print $socket "JOIN $channel\r\n";

# Invio del testo letto dal file
print $socket "PRIVMSG $channel :$text\r\n";

# Chiusura della connessione
print $socket "QUIT\r\n";
close($socket);
