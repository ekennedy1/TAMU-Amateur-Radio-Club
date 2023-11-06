document.addEventListener('DOMContentLoaded', function() {
  // Check if the user has already visited this page in the current session
  if (sessionStorage.getItem('userVisited')) {
    // Hide the logged-in alert
    document.getElementById('loggedInAlert').style.display = 'none';
  } else {
    // Set a session storage item to track that the user has visited the page
    sessionStorage.setItem('userVisited', 'true');
  }
});
