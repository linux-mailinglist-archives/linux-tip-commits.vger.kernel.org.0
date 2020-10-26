Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF97298C29
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Oct 2020 12:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773898AbgJZLio (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Oct 2020 07:38:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39364 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1773895AbgJZLin (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 26 Oct 2020 07:38:43 -0400
Date:   Mon, 26 Oct 2020 11:38:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603712321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g/Hp1IZzQPnvyN8blfRC1FcHx3jPg+5MF1FJmSmsDs8=;
        b=Vxyx6vBdfL2Soy1Jj1AbUeOF8/4fd9yZAP7Yqok5ujjlF1A0gf7g4tRRZFvl2XNl8HnL6d
        VRbjmBeYUg8BKEDbWnLEPoP+H+4MuH1Rk8rRe07RLq2HQWMnHGlOWsU29lSn6BL+pp9oDR
        OevJcq7h2J3rLSnrQ7Jzuo15feNawfJGU5Ap5gVk7voJf4E38jP7WLW3H8P6oMmVfPjxAU
        R9Wb9bvZXi5hlcdT1llgqEVUb3YqKJOWt2lQfD5SAzxAmfP9YETGjQ0tCiAH+BI12X0nMd
        OM8Y8PqC5P0eaERJQyOt0+oogfIHXYV53W6S5QrdHEA62WgKJ902iZ9DmEYWZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603712321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g/Hp1IZzQPnvyN8blfRC1FcHx3jPg+5MF1FJmSmsDs8=;
        b=q0hRJKGmnWAqXWan55tmGzrrd8g4WiYP/srRMfTumzWdDGnRYh76bHe1XDcPnsmZR1/cy6
        filcNdBW2fWpWkBA==
From:   "tip-bot2 for Tom Rix" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Remove unneeded break
Cc:     Tom Rix <trix@redhat.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201019200803.17619-1-trix@redhat.com>
References: <20201019200803.17619-1-trix@redhat.com>
MIME-Version: 1.0
Message-ID: <160371232026.397.1039892966765369024.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     633cdaf29ec4aae29868320adb3a4f1c5b8c0eac
Gitweb:        https://git.kernel.org/tip/633cdaf29ec4aae29868320adb3a4f1c5b8c0eac
Author:        Tom Rix <trix@redhat.com>
AuthorDate:    Mon, 19 Oct 2020 13:08:03 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 26 Oct 2020 12:24:35 +01:00

x86/mce: Remove unneeded break

A break is not needed if it is preceded by a return.

Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201019200803.17619-1-trix@redhat.com
---
 arch/x86/kernel/cpu/mce/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4102b86..51bf910 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1811,11 +1811,9 @@ static int __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
 	case X86_VENDOR_INTEL:
 		intel_p5_mcheck_init(c);
 		return 1;
-		break;
 	case X86_VENDOR_CENTAUR:
 		winchip_mcheck_init(c);
 		return 1;
-		break;
 	default:
 		return 0;
 	}
