Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E97387B8E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 May 2021 16:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbhEROp7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 18 May 2021 10:45:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60632 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239086AbhEROpm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 18 May 2021 10:45:42 -0400
Date:   Tue, 18 May 2021 14:44:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621349062;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ftFJxepr8HR6dXe3KUGFNC6xKl8duAyRgzCVRkeu4KQ=;
        b=lgqBtTO0B2cD8mJwNsqNDHfA3II+ySSlxt45X5TMvcmlcihGCIb282D5gkFn0nb8n16heE
        LCysIBDQNYbA3fWxQi6L/Yp/93KAouB3nl/vrwlsqCQMulPYQXw2TDYTadI4k0iEAna+vU
        8i+lGmWADk6Ct6DmsGWvv6cNlCI0lS3c2wgFpfBOve3Jp0bTx0YzNeJ9lF20xEYziw9ydx
        E/w+AUiJAs/B4reDnUPDT4trMDBFHo/7skCzUEO6Ofg2P2Bc9Ugnp3Gtwc+f0GD7y6yVQ6
        uo4QyXh+Salkae8xyp0YakCfGXbqqw3yO/tdisn/g/ZdZkFInP8FATZ1x96eTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621349062;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ftFJxepr8HR6dXe3KUGFNC6xKl8duAyRgzCVRkeu4KQ=;
        b=10fYYckhIJugKI57GpKw6urPQrdCvzwvBoDcb8YTtH4U9NHR0rHA9UH4lzCYgB5Agy2h64
        B4bVGeW0ofj3C5Aw==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/splitlock] Documentation/x86: Add ratelimit in buslock.rst
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210419214958.4035512-5-fenghua.yu@intel.com>
References: <20210419214958.4035512-5-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <162134906105.29796.18308488746834241121.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/splitlock branch of tip:

Commit-ID:     d28397eaf4c27947a1ffc720d42e8b3a33ae1e2a
Gitweb:        https://git.kernel.org/tip/d28397eaf4c27947a1ffc720d42e8b3a33ae1e2a
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Mon, 19 Apr 2021 21:49:58 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 May 2021 16:39:31 +02:00

Documentation/x86: Add ratelimit in buslock.rst

ratelimit is a new command line option for bus lock handling. Add proper
documentation.

[ tglx: Massaged documentation ]

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20210419214958.4035512-5-fenghua.yu@intel.com

---
 Documentation/x86/buslock.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/x86/buslock.rst b/Documentation/x86/buslock.rst
index 159ff6b..7c051e7 100644
--- a/Documentation/x86/buslock.rst
+++ b/Documentation/x86/buslock.rst
@@ -63,6 +63,11 @@ parameter "split_lock_detect". Here is a summary of different options:
 |		   |When both features are	|			|
 |		   |supported, fatal in #AC	|			|
 +------------------+----------------------------+-----------------------+
+|ratelimit:N	   |Do nothing			|Limit bus lock rate to	|
+|(0 < N <= 1000)   |				|N bus locks per second	|
+|		   |				|system wide and warn on|
+|		   |				|bus locks.		|
++------------------+----------------------------+-----------------------+
 
 Usages
 ======
@@ -102,3 +107,20 @@ fatal
 -----
 
 In this case, the bus lock is not tolerated and the process is killed.
+
+ratelimit
+---------
+
+A system wide bus lock rate limit N is specified where 0 < N <= 1000. This
+allows a bus lock rate up to N bus locks per second. When the bus lock rate
+is exceeded then any task which is caught via the buslock #DB exception is
+throttled by enforced sleeps until the rate goes under the limit again.
+
+This is an effective mitigation in cases where a minimal impact can be
+tolerated, but an eventual Denial of Service attack has to be prevented. It
+allows to identify the offending processes and analyze whether they are
+malicious or just badly written.
+
+Selecting a rate limit of 1000 allows the bus to be locked for up to about
+seven million cycles each second (assuming 7000 cycles for each bus
+lock). On a 2 GHz processor that would be about 0.35% system slowdown.
