Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E53223A4A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Jul 2020 13:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgGQLWN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Jul 2020 07:22:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40090 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgGQLWI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Jul 2020 07:22:08 -0400
Date:   Fri, 17 Jul 2020 11:22:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594984926;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=idHQYFdvpTfN+lfpXHJSjMEYHdLgakbFkGuD1k5Q+4Y=;
        b=UdIeY/UD2fyo7vgR15iVMYJHo21y+tjA2y/QLaqCalEsmdy5ZtIW7de9pwUNvhtVmj3qFh
        Bc2xA99yEmuFRhcrwFBvN4W5UXIVeAfl09WLzVNl6AFTGIx6w4rmyJ2bgyV4nKKzZiN7Tk
        KUwE97tExwKHyExhxX+peqX3bge/Qsi8OXaoZ9KO+tXMRW5fHMFK4uaE2PGURmu2KqSmbC
        VO8jclcqVNZE9SsDYjgh3PLshE5EzpZSE3rDNp7cW865mRwLpE+CEycxGl04JuOYnZnQM9
        rh1cv//6xsRhw4rrV3UfIOUY1yXOQV4iBVR9jIQdCHXnEusIhF5pMAU/7OAaMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594984926;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=idHQYFdvpTfN+lfpXHJSjMEYHdLgakbFkGuD1k5Q+4Y=;
        b=3ScILym6/1YlTZ2h9kDhm5zUcqcaF6/R6c04q7cwQlCIDPsZCHJLF/NTRq3+Ks0EXy9g1f
        dGqD8ZU/8AOv1EBQ==
From:   "tip-bot2 for Alexander A. Klimov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] docs: locking: Replace HTTP links with HTTPS ones
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200713115728.33905-1-grandmaster@al2klimov.de>
References: <20200713115728.33905-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Message-ID: <159498492557.4006.1686830928434874554.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     482cbb6cc33dca60091048631cd0a8dde72c3da7
Gitweb:        https://git.kernel.org/tip/482cbb6cc33dca60091048631cd0a8dde72c3da7
Author:        Alexander A. Klimov <grandmaster@al2klimov.de>
AuthorDate:    Mon, 13 Jul 2020 13:57:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Jul 2020 23:19:51 +02:00

docs: locking: Replace HTTP links with HTTPS ones

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200713115728.33905-1-grandmaster@al2klimov.de
---
 Documentation/locking/mutex-design.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/locking/mutex-design.rst b/Documentation/locking/mutex-design.rst
index 4d8236b..8f3e9a5 100644
--- a/Documentation/locking/mutex-design.rst
+++ b/Documentation/locking/mutex-design.rst
@@ -18,7 +18,7 @@ as an alternative to these. This new data structure provided a number
 of advantages, including simpler interfaces, and at that time smaller
 code (see Disadvantages).
 
-[1] http://lwn.net/Articles/164802/
+[1] https://lwn.net/Articles/164802/
 
 Implementation
 --------------
