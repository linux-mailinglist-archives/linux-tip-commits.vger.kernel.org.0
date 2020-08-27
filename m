Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DA3254334
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Aug 2020 12:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgH0KLn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 27 Aug 2020 06:11:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37720 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgH0KLm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 27 Aug 2020 06:11:42 -0400
Date:   Thu, 27 Aug 2020 10:11:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598523100;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ludH0QWLBk1PhghpnaF6s/D+fY9xJ/+IYS/8HOOkWP8=;
        b=tU4plJvC5JVsLweEow0+7j42LNnHb60W+s0YOGaDARHTgnwMXVmQdgvbrj15WHBjplBUvK
        8sBNDTBTgz+m7pVxh7i7Iv2vmDkYu5283XF13O0kBizDRZ6ScAuWfB+WtaLRhrCK7FRVL8
        CE8hUx9Hk6VECYaIFRI1/gzbl/Jkmk3SCjWOQGjmTyKRRtL+UyeHplC4uYFbkeIinFLH6F
        0hBn0R/WZNXk6kUdpPFuQHuMl27qEFzBRi8Qzrw+vkjAimJQSecOEbA+EQCuo//XhUewv+
        wrtQypqTlzVYmqTst+9kSR571iLOWiDjG/lg+Yz2Nzcuas+31+0kCE26CTMmCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598523100;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ludH0QWLBk1PhghpnaF6s/D+fY9xJ/+IYS/8HOOkWP8=;
        b=amH7MCmjU3eShZpNaocsgSsEIL1gmDslwjtvpNMxfA3GyM46iPW+wtyOfV4LMuvJeBp4uR
        KOJtToNRLLSUhUBg==
From:   "tip-bot2 for Wang Hai" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mpparse: Remove duplicate io_apic.h include
Cc:     Hulk Robot <hulkci@huawei.com>, Wang Hai <wanghai38@huawei.com>,
        Borislav Petkov <bp@suse.de>,
        Pekka Enberg <penberg@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200819112910.7629-1-wanghai38@huawei.com>
References: <20200819112910.7629-1-wanghai38@huawei.com>
MIME-Version: 1.0
Message-ID: <159852309922.20229.10538355167500670511.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     e33ab2064836600603289ad2ed0ca3424f395fa8
Gitweb:        https://git.kernel.org/tip/e33ab2064836600603289ad2ed0ca3424f395fa8
Author:        Wang Hai <wanghai38@huawei.com>
AuthorDate:    Wed, 19 Aug 2020 19:29:10 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 27 Aug 2020 12:00:28 +02:00

x86/mpparse: Remove duplicate io_apic.h include

Remove asm/io_apic.h which is included more than once.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Pekka Enberg <penberg@kernel.org>
Link: https://lkml.kernel.org/r/20200819112910.7629-1-wanghai38@huawei.com
---
 arch/x86/kernel/mpparse.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index 411af4a..00e5162 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -24,7 +24,6 @@
 #include <asm/irqdomain.h>
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
-#include <asm/io_apic.h>
 #include <asm/proto.h>
 #include <asm/bios_ebda.h>
 #include <asm/e820/api.h>
