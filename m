Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCB328822C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731943AbgJIGf1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:35:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55396 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731822AbgJIGfO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:14 -0400
Date:   Fri, 09 Oct 2020 06:35:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225312;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=N1Z4zg0Xu/QXX8DuION/BFA8FyeGcWDJ+1NV0PRaSEA=;
        b=mQW1gzsOveOah52gGq1+N9cC++RmsYgR9bwED11AkkJ6cStAzy36dpyr6sYIBRellsp/e/
        qnbxJaySLOxXgyxg5NQvFlcw46ri/cP2q7aG1wwEB8cJ2UEWXZxP8Z9W5/PlLH+//uViTD
        gf2oT+pH0WJD2pPDhYiEx+PpQLKrf6WPrUPKkBpXTEPvM1a33bfiec/0tUk6l1YvWPKFOS
        wauIH5seoX5CU2EITfWVKYHNBw/UaeqbjLmte6LKbJ9g1OmVSKWgZYUcpmVzFgSc/x8n5e
        A3fNZNnamD5rtTdumdpfs9sKZ1VlZSOunDLE/rPQk8XIE23x32rbDvG3tUIlpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225312;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=N1Z4zg0Xu/QXX8DuION/BFA8FyeGcWDJ+1NV0PRaSEA=;
        b=xTGseGh7g0dhxwhRKYsU3i/x7ylczHjy6q01S6IYcD8Qcru/TcI907cfWtr4JebgSLnkcO
        7mb1iHAwoDfupTBQ==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Avoid null pointer dereference when buf
 fails to allocate
Cc:     Colin Ian King <colin.king@canonical.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222531194.7002.9170405608825348063.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     58db5785b0d76be4582a32a7900acce88e691d36
Gitweb:        https://git.kernel.org/tip/58db5785b0d76be4582a32a7900acce88e691d36
Author:        Colin Ian King <colin.king@canonical.com>
AuthorDate:    Thu, 16 Jul 2020 15:38:56 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:45:35 -07:00

refperf: Avoid null pointer dereference when buf fails to allocate

Currently in the unlikely event that buf fails to be allocated it
is dereferenced a few times.  Use the errexit flag to determine if
buf should be written to to avoid the null pointer dereferences.

Addresses-Coverity: ("Dereference after null check")
Fixes: f518f154ecef ("refperf: Dynamically allocate experiment-summary output buffer")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index d9291f8..952595c 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -546,9 +546,11 @@ static int main_func(void *arg)
 	// Print the average of all experiments
 	SCALEOUT("END OF TEST. Calculating average duration per loop (nanoseconds)...\n");
 
-	buf[0] = 0;
-	strcat(buf, "\n");
-	strcat(buf, "Runs\tTime(ns)\n");
+	if (!errexit) {
+		buf[0] = 0;
+		strcat(buf, "\n");
+		strcat(buf, "Runs\tTime(ns)\n");
+	}
 
 	for (exp = 0; exp < nruns; exp++) {
 		u64 avg;
