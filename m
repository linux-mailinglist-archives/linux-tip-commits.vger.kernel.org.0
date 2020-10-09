Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0902882BE
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbgJIGj3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:39:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55396 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731856AbgJIGfR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:17 -0400
Date:   Fri, 09 Oct 2020 06:35:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225315;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XJJJo1YD/SSqfzuRudPzIInOHQ5ecKd2ycIMbXNrTeg=;
        b=z6scKyhHkIkO3JOl9k+mzFVuxE6hXFfPfvPnE6NWeZX5byEhAdudoVbWiCoHRoqth24bLy
        y0Uphod2R66AI8+uw4qwRm6vEXw1/XzQ59oQtMElM696inXA7U7hJcreamSLn/e0aP7TKA
        oQBnzPJFyqmK6tRGhyNNzYew6aiJ1SiCHr4LncvbX/ZvnGtY2Cos/OaJO9fLm9uabuXPI2
        9PVJ0ux3aRg9/NXQfCcPjp3SLd/cmMuDC58F81ObI+IyaXPPg/Id6NX+iWZwyvIgY4k/W0
        wONY2ZPhGnR+lw+Zkyow8VIKAMlPx2d9XUHWzAIECo+g/DQbqLMdjUB5cHAbzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225315;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XJJJo1YD/SSqfzuRudPzIInOHQ5ecKd2ycIMbXNrTeg=;
        b=766A9YW0AO/lJObgUksWWaHPRWVPbNKk+2JwOigeQc0uppTSixu+EDvSrvqLZrZFpG6rhf
        1HRIACaA0Uw3noCQ==
From:   "tip-bot2 for Alexander A. Klimov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Replace HTTP links with HTTPS ones
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222531490.7002.13094857774287502879.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     afcdf2319d11e0d68e45babd5df65f79771074b5
Gitweb:        https://git.kernel.org/tip/afcdf2319d11e0d68e45babd5df65f79771074b5
Author:        Alexander A. Klimov <grandmaster@al2klimov.de>
AuthorDate:    Mon, 13 Jul 2020 21:37:06 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:45:32 -07:00

rcutorture: Replace HTTP links with HTTPS ones

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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/doc/rcu-test-image.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt b/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt
index 449cf57..cc280ba 100644
--- a/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt
+++ b/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt
@@ -36,7 +36,7 @@ References:
 	https://help.ubuntu.com/community/JeOSVMBuilder
 	http://wiki.libvirt.org/page/UbuntuKVMWalkthrough
 	http://www.moe.co.uk/2011/01/07/pci_add_option_rom-failed-to-find-romfile-pxe-rtl8139-bin/ -- "apt-get install kvm-pxe"
-	http://www.landley.net/writing/rootfs-howto.html
-	http://en.wikipedia.org/wiki/Initrd
-	http://en.wikipedia.org/wiki/Cpio
+	https://www.landley.net/writing/rootfs-howto.html
+	https://en.wikipedia.org/wiki/Initrd
+	https://en.wikipedia.org/wiki/Cpio
 	http://wiki.libvirt.org/page/UbuntuKVMWalkthrough
