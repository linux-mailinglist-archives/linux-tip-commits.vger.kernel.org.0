Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1380438C304
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 May 2021 11:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbhEUJ11 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 21 May 2021 05:27:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52688 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhEUJ1Y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 21 May 2021 05:27:24 -0400
Date:   Fri, 21 May 2021 09:25:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621589149;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FqZi0jGE9bL2l3ok4cZVdsMkw3+LatP2BfeAC+najTA=;
        b=yJGUtIpb3vL5g6/uBrRjLwk9EM5vS+bF5+/PqLq91XYAL+1f2KVsBM36uZ2lK5CgdQDUJs
        b90mNELSCofhTJXKi9x4u6DillkWX/NL2tkM4YKSFWW42etUo3ybz2BP2oMC3zizSEiFJG
        BWGDfm/V89VKTK78W074fYJapZArUOrcuwYRmJ0Si/IvRWMXCOjpn3ms6gfBgHOem/r2HV
        XxmqyVP0XiZQZ+kyt/y4Q/tcyD+Ij2w7JAYsAjPwvx5xBSKqcqO3wUk8y6sdHkA3ym6i27
        6XsmLPPtTEiFU2bdM+8Dcjx3WKF7v9HGR87mE+T2euod7msfy0YfAqLjH1UWyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621589149;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FqZi0jGE9bL2l3ok4cZVdsMkw3+LatP2BfeAC+najTA=;
        b=TygcYo6UFcnPrGRuENFZ8laYneMjtYs+0RV5ssY+bCnfBDvPuD2gWFsvnOqfyxtUef0yty
        9Xb9MVFLs3xUMwBQ==
From:   "tip-bot2 for Joe Richey" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/elf: Use _BITUL() macro in UAPI headers
Cc:     Joe Richey <joerichey@google.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210521085849.37676-2-joerichey94@gmail.com>
References: <20210521085849.37676-2-joerichey94@gmail.com>
MIME-Version: 1.0
Message-ID: <162158914834.29796.12096447780356064169.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     d06aca989c243dd9e5d3e20aa4e5c2ecfdd07050
Gitweb:        https://git.kernel.org/tip/d06aca989c243dd9e5d3e20aa4e5c2ecfdd07050
Author:        Joe Richey <joerichey@google.com>
AuthorDate:    Fri, 21 May 2021 01:58:42 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 21 May 2021 11:12:52 +02:00

x86/elf: Use _BITUL() macro in UAPI headers

Replace BIT() in x86's UAPI header with _BITUL(). BIT() is not defined
in the UAPI headers and its usage may cause userspace build errors.

Fixes: 742c45c3ecc9 ("x86/elf: Enumerate kernel FSGSBASE capability in AT_HWCAP2")
Signed-off-by: Joe Richey <joerichey@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210521085849.37676-2-joerichey94@gmail.com
---
 arch/x86/include/uapi/asm/hwcap2.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/uapi/asm/hwcap2.h b/arch/x86/include/uapi/asm/hwcap2.h
index 5fdfcb4..054604a 100644
--- a/arch/x86/include/uapi/asm/hwcap2.h
+++ b/arch/x86/include/uapi/asm/hwcap2.h
@@ -2,10 +2,12 @@
 #ifndef _ASM_X86_HWCAP2_H
 #define _ASM_X86_HWCAP2_H
 
+#include <linux/const.h>
+
 /* MONITOR/MWAIT enabled in Ring 3 */
-#define HWCAP2_RING3MWAIT		(1 << 0)
+#define HWCAP2_RING3MWAIT		_BITUL(0)
 
 /* Kernel allows FSGSBASE instructions available in Ring 3 */
-#define HWCAP2_FSGSBASE			BIT(1)
+#define HWCAP2_FSGSBASE			_BITUL(1)
 
 #endif
