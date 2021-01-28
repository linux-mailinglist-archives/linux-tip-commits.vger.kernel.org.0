Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8183075DD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 28 Jan 2021 13:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhA1MWZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 28 Jan 2021 07:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhA1MWW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 28 Jan 2021 07:22:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C2DC061573;
        Thu, 28 Jan 2021 04:21:38 -0800 (PST)
Date:   Thu, 28 Jan 2021 12:21:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611836497;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0XFsQOXaUf6eQkfskm6e+uuyZvnZrXDmgTVqxDe1KcQ=;
        b=mjSCPamW299FhhXP8lxN3JCdAO4Klcu0RKLzjmr5Z/4pigjSB6Y55fL1Os3EiNcWy1bY3F
        +HiCtIEUGUag//5dTaMYy44ve93QRtLLbjOJDhCzR5ucbpEb2NpLclOYs00kyj5prPtHMm
        Bga5J+kQqsgjQij+qPBnU5WnUw6sGg0I7cMSTl1WqYECEKlPRuCCXYqFIzDObtRBw2er4q
        7mXfDmH0NKRyIpyXRmZwbqBxKR8IfZLY3g99uyQgmNKo47SicVQKbPR7ezMaZIsqyUmKlu
        l5B9LWoAgIkj0VQe4vtLC48+R8pPxV1D8hYTQ0Pzggm6eJ8+0+NWZ9hUTuUtrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611836497;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0XFsQOXaUf6eQkfskm6e+uuyZvnZrXDmgTVqxDe1KcQ=;
        b=MazKJum34oteacmMZwlKRUv0I0njn3FU0f+Ojb4890GlSkhNXQPrI1DfsecD669+RKbXDI
        rwhq5PcN37+4lxCg==
From:   "tip-bot2 for Jangwoong Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Remove unneeded gotos
Cc:     Jangwoong Kim <6812skiii@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201230122953.10473-1-6812skiii@gmail.com>
References: <20201230122953.10473-1-6812skiii@gmail.com>
MIME-Version: 1.0
Message-ID: <161183649645.23325.6834431262596546506.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0f9438503ea1312ef49be4d9762e0f0006546364
Gitweb:        https://git.kernel.org/tip/0f9438503ea1312ef49be4d9762e0f0006546364
Author:        Jangwoong Kim <6812skiii@gmail.com>
AuthorDate:    Wed, 30 Dec 2020 21:29:53 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 28 Jan 2021 13:20:18 +01:00

futex: Remove unneeded gotos

Get rid of gotos that do not contain any cleanup. These were not removed in
commit 9180bd467f9a ("futex: Remove put_futex_key()").

Signed-off-by: Jangwoong Kim <6812skiii@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201230122953.10473-1-6812skiii@gmail.com


---
 kernel/futex.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index d0775aa..f3570a2 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3024,7 +3024,7 @@ retry:
 		 * Success, we're done! No tricky corner cases.
 		 */
 		if (!ret)
-			goto out_putkey;
+			return ret;
 		/*
 		 * The atomic access to the futex value generated a
 		 * pagefault, so retry the user-access and the wakeup:
@@ -3041,7 +3041,7 @@ retry:
 		 * wake_futex_pi has detected invalid state. Tell user
 		 * space.
 		 */
-		goto out_putkey;
+		return ret;
 	}
 
 	/*
@@ -3062,7 +3062,7 @@ retry:
 
 		default:
 			WARN_ON_ONCE(1);
-			goto out_putkey;
+			return ret;
 		}
 	}
 
@@ -3073,7 +3073,6 @@ retry:
 
 out_unlock:
 	spin_unlock(&hb->lock);
-out_putkey:
 	return ret;
 
 pi_retry:
