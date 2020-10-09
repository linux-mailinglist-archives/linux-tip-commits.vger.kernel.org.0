Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580C22884CF
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 10:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732941AbgJIICt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 04:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732482AbgJIH6q (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 03:58:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF655C0613D5;
        Fri,  9 Oct 2020 00:58:46 -0700 (PDT)
Date:   Fri, 09 Oct 2020 07:58:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602230325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BkngLRjsZ7dZu702gex78aSy8k2gUExB5g4P0+TU86I=;
        b=SCupEozwJVD0SOQDoNba/oVXIkBek2uJHfWMw4qLfB9zfrEMtkhccaT50tGIqsI7VXU6SO
        eIPuiE94EFCPnICGWgVkoDa1/cm/+DWNzi9bFnF8mLbSmf89f301ugh9A1srUdtKH2mrgN
        NhDtj8clrbpsf5WJ/GE9gkQljkxhFBQA0Bmh4+W9qh8S+odymHNoY+YxU6UP4xJlUZ0SsQ
        lkrTiFDw4bPx+S/l2njRPkMUBpbSnR2lzpxkVpRcmqrYvoxy9CQ3IlMK6A8/jtbiFxvd6z
        3CksSP6+NbIxuvua4uH8YcKzZmH6SYs2wKWFErnALAh6wraT0frtW/KuVzDbMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602230325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BkngLRjsZ7dZu702gex78aSy8k2gUExB5g4P0+TU86I=;
        b=rL7LG4wsOU3e/JgNn/X6yg1YMqgdHZtt9a72h2tnxX/UVenQWWfkDcRjUl3i1+jtQtBKQq
        EC46g+ShnhUSNrAA==
From:   "tip-bot2 for Alexander A. Klimov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] Replace HTTP links with HTTPS ones: LKMM
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160223032428.7002.3748356645341664576.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1e44e6e82e7b4d2bae70a8a0b68f7d4f213b0e5f
Gitweb:        https://git.kernel.org/tip/1e44e6e82e7b4d2bae70a8a0b68f7d4f213b0e5f
Author:        Alexander A. Klimov <grandmaster@al2klimov.de>
AuthorDate:    Mon, 06 Jul 2020 21:03:24 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 03 Sep 2020 09:51:00 -07:00

Replace HTTP links with HTTPS ones: LKMM

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
          If both the HTTP and HTTPS versions
          return 200 OK and serve the same content:
            Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/references.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/references.txt b/tools/memory-model/Documentation/references.txt
index ecbbaa5..c5fdfd1 100644
--- a/tools/memory-model/Documentation/references.txt
+++ b/tools/memory-model/Documentation/references.txt
@@ -120,7 +120,7 @@ o	Jade Alglave, Luc Maranget, and Michael Tautschnig. 2014. "Herding
 
 o	Jade Alglave, Patrick Cousot, and Luc Maranget. 2016. "Syntax and
 	semantics of the weak consistency model specification language
-	cat". CoRR abs/1608.07531 (2016). http://arxiv.org/abs/1608.07531
+	cat". CoRR abs/1608.07531 (2016). https://arxiv.org/abs/1608.07531
 
 
 Memory-model comparisons
