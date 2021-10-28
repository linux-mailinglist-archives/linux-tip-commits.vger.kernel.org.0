Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D8643DCF0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 28 Oct 2021 10:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhJ1Ic3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 28 Oct 2021 04:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhJ1Ic2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 28 Oct 2021 04:32:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0571C061570;
        Thu, 28 Oct 2021 01:30:01 -0700 (PDT)
Date:   Thu, 28 Oct 2021 08:29:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635409799;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TCOxPPu0wAhGq4BhYH0OeM0Eb5ykRbeBvM2nzDSMAj0=;
        b=E12TZgKLMH8pmjzvbqISYRHIAfV2XPkCyand2eJv2ypLBHwmPhVHuy1Zj8xvf4KLk/p2ei
        opimE9hwmT2nAKMIowjxYhSw+FB/UBG2xj02pgB3BpDnhya0JfQjPCF//seJ3BQpTKW9+R
        R3Z1GtVl9wGZisUsyxpH9Naz9sSMmy9Kma/58TrCdSe83NqGKwnqgrYTce+TlvtzaayH9v
        R5FQUN7ALbB2cR3F81BFnAQM+k2CNThSIm5Xg14bNHlo92WQVbJAMlFfVIg/cfPrN1WzTL
        89p4kzBqnetm/X1V0HyJrWPW0ntALyTXYkYRHAAEQEJNfF+/Ng5mGyM3o1+yCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635409799;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TCOxPPu0wAhGq4BhYH0OeM0Eb5ykRbeBvM2nzDSMAj0=;
        b=M0dmY6omFH/HP5kKLd7L09fRgDBa23TFl7uU1RLaRYD8Bd5hx6mV6LB+QBR1np/hWterfm
        KmeO6ivK7MtdM3AQ==
From:   "tip-bot2 for Stephen Rothwell" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Include vmalloc.h for vzalloc()
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211025151144.552c60ca@canb.auug.org.au>
References: <20211025151144.552c60ca@canb.auug.org.au>
MIME-Version: 1.0
Message-ID: <163540979775.626.10330094278722511919.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     6ccd63f07775961b3212c098abad05bcda931045
Gitweb:        https://git.kernel.org/tip/6ccd63f07775961b3212c098abad05bcda931045
Author:        Stephen Rothwell <sfr@canb.auug.org.au>
AuthorDate:    Mon, 25 Oct 2021 15:04:13 +11:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 28 Oct 2021 10:12:54 +02:00

x86/fpu: Include vmalloc.h for vzalloc()

Explicitly include that header to avoid build errors when vzalloc()
becomes "invisible" to the compiler due to header reorganizations.

This is not a problem in the tip tree but occurred when integrating
linux-next.

 [ bp: Commit message. ]

Link: https://lore.kernel.org/r/20211025151144.552c60ca@canb.auug.org.au
Fixes: 69f6ed1d14c6 ("x86/fpu: Provide infrastructure for KVM FPU cleanup")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/fpu/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 290836d..8ea306b 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -16,6 +16,7 @@
 
 #include <linux/hardirq.h>
 #include <linux/pkeys.h>
+#include <linux/vmalloc.h>
 
 #include "context.h"
 #include "internal.h"
