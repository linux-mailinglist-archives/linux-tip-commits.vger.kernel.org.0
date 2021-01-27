Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C6D306433
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Jan 2021 20:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344525AbhA0Tfa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 27 Jan 2021 14:35:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58428 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhA0Tb6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 27 Jan 2021 14:31:58 -0500
Date:   Wed, 27 Jan 2021 19:31:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611775876;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qMx1yyWjUsFSF856cxeTa+LDkK/VFe+OTny6AAtHBqs=;
        b=SYwO/M8YGtFViRZnF1LyRMt+D3AEpy02jVy2dGhaaFED8pGNGRnsLKGHdOOQJ0VDuJHZHd
        KDrDuxGfUWkQ3FM+RqZaUZvPMtN33y4PdzBn8ftOS3mwEGV/bjyzuCLwT4lSZdcC1YWBhW
        6SDJN/7vD0jmt6AJ7C93+Dpai5SHO9Rwz48nb629V/M5pPFf4hmPPqgBS4tYfL6NNa0KS6
        Uuf8qzIMoAEPRD5HhfHpKCpqZN5nMSowtfcElqgd0kbmYmlio+7F/hBmYUXmtZTJs384fM
        hO+q9NI0ZRMU2KGWBDj1DUcJWjqMRLMC11d+madn+c5CBYllErF+NoYzf+aD5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611775876;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qMx1yyWjUsFSF856cxeTa+LDkK/VFe+OTny6AAtHBqs=;
        b=7cQ6x9eGwLcZK01I6OK0cBdxLVZbAwJ3XdVkT5cb65lW+lYOOrPgu2iO+TQejELqfuWQkf
        X2Vb60SsQy5yf/Bw==
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
Message-ID: <161177587575.23325.13374698629032171479.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     cfb8364aec4317f8e0695e4c9779b3413ce36ef4
Gitweb:        https://git.kernel.org/tip/cfb8364aec4317f8e0695e4c9779b3413ce36ef4
Author:        Jangwoong Kim <6812skiii@gmail.com>
AuthorDate:    Wed, 30 Dec 2020 21:29:53 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Jan 2021 12:37:27 +01:00

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
