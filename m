Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C232EEE46
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Jan 2021 09:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbhAHICS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 8 Jan 2021 03:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbhAHICS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 8 Jan 2021 03:02:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C3FC0612F5;
        Fri,  8 Jan 2021 00:01:38 -0800 (PST)
Date:   Fri, 08 Jan 2021 08:01:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610092895;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c2DTisWit8OV2tHztEcM+aLYzs9o7pwomLKcEqJtNgI=;
        b=WhI5txmq/6XQINA/PvaO4q10ClL6mwpT+H89i62InwA4KgnXyYH2ZL4b3W6Oe6PTZjSsRf
        Nj/+czbD61vVNwjOSWRI9URkuwNVkawV1U/pzld+2BD3Ph/1rFmuplpaPE0OEFztJBQld1
        2mnorLRWqULRPKNr4Mmjhdk3vvlHC8LJ2adCg75B1InLo9y/xI3SN4Q/Q2jXelmiRMc+wz
        M+MrYc8xh7stlZ4iJUo8wdoOyy+0+zCrOCO3i6zeelNjK/KYP48xVmaw5NT8kfM2dGC1HY
        IyghmcX3X/zllmHnBh0P17K4l9QOpX6S0XpmXN4G6ir5xu4Y649ccBSBqkk2JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610092895;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c2DTisWit8OV2tHztEcM+aLYzs9o7pwomLKcEqJtNgI=;
        b=ZKJOAq6ijCehZb0BwtOKy0NmbUkf/XEiVHhX1I370i5gTk3HpqkEW73OyICGEkXABm+l9Z
        m38H406GIEJdHrBg==
From:   "tip-bot2 for Tom Rix" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add printf attribute to log function
Cc:     Tom Rix <trix@redhat.com>, Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201221160009.3752017-1-trix@redhat.com>
References: <20201221160009.3752017-1-trix@redhat.com>
MIME-Version: 1.0
Message-ID: <161009289493.414.10503732751311581962.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     91031e096e1fa0216027bfb7fdca931225aebbf0
Gitweb:        https://git.kernel.org/tip/91031e096e1fa0216027bfb7fdca931225aebbf0
Author:        Tom Rix <trix@redhat.com>
AuthorDate:    Mon, 21 Dec 2020 08:00:09 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 08 Jan 2021 08:55:02 +01:00

x86/resctrl: Add printf attribute to log function

Mark the function with the __printf attribute to allow the compiler to
more thoroughly typecheck its arguments against a format string with
-Wformat and similar flags.

 [ bp: Massage commit message. ]

Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20201221160009.3752017-1-trix@redhat.com
---
 arch/x86/kernel/cpu/resctrl/internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index ee71c47..c4d320d 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -572,6 +572,7 @@ union cpuid_0x10_x_edx {
 
 void rdt_last_cmd_clear(void);
 void rdt_last_cmd_puts(const char *s);
+__printf(1, 2)
 void rdt_last_cmd_printf(const char *fmt, ...);
 
 void rdt_ctrl_update(void *arg);
