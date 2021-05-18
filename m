Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FAB387B92
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 May 2021 16:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240911AbhEROqC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 18 May 2021 10:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239899AbhEROpv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 18 May 2021 10:45:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40927C061346;
        Tue, 18 May 2021 07:44:25 -0700 (PDT)
Date:   Tue, 18 May 2021 14:44:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621349063;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bawpa71MGjH1d+7qGXUM/Sq9NhjHZXYhRPUfZ1mfNqw=;
        b=anyY4xuh+D11A+cc15RvSLgNRerOtjr9sizNydQScHiGKzLh5UD/6JZJ3o+G1807f57Ovh
        8cDT33ikQ3P/yybB+/CzzpMeuHvsf8pYwOqh4HXwgj4AUM7UTpvy//INwog2YdXKMprf4z
        PJVf4Qi8+PjoqzY7s54izD1nT2gGAE+PQU6RPYBbZp/bYOcpbKH2s/Fky7Io5dgtofx7Ko
        rkvRD64kvTqSpBE+K7gC/cjBpmA70Jre57elFQQ/TztsvJFRmjEJ5ZWqEipReXiy8mR/p0
        5y7MctQZW7DJGeWnoeaOD9R8km3swvc2ayB8JOzDG5eJcX0r0fL5jqR6l2SVyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621349063;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bawpa71MGjH1d+7qGXUM/Sq9NhjHZXYhRPUfZ1mfNqw=;
        b=MvH309NktgVZonBW20OwAk5D2xh+z32nRNQ1m52Q/3OF/f4kvq+z1fxwfRTg79Uwz6LevF
        bq+5medBV4I1kMAw==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/splitlock] Documentation/admin-guide: Add bus lock ratelimit
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210419214958.4035512-4-fenghua.yu@intel.com>
References: <20210419214958.4035512-4-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <162134906161.29796.1181461995523391470.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/splitlock branch of tip:

Commit-ID:     9d839c280b64817345c2fa462c0027a9bd742361
Gitweb:        https://git.kernel.org/tip/9d839c280b64817345c2fa462c0027a9bd742361
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Mon, 19 Apr 2021 21:49:57 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 May 2021 16:39:31 +02:00

Documentation/admin-guide: Add bus lock ratelimit

Since bus lock rate limit changes the split_lock_detect parameter,
update the documentation for the change.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20210419214958.4035512-4-fenghua.yu@intel.com

---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb89dbd..ca94624 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5283,6 +5283,14 @@
 				  exception. Default behavior is by #AC if
 				  both features are enabled in hardware.
 
+			ratelimit:N -
+				  Set system wide rate limit to N bus locks
+				  per second for bus lock detection.
+				  0 < N <= 1000.
+
+				  N/A for split lock detection.
+
+
 			If an #AC exception is hit in the kernel or in
 			firmware (i.e. not while executing in user mode)
 			the kernel will oops in either "warn" or "fatal"
