Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7942534EA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Aug 2020 18:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgHZQ3s (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 Aug 2020 12:29:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60044 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgHZQ3q (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 Aug 2020 12:29:46 -0400
Date:   Wed, 26 Aug 2020 16:29:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598459384;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jM1CwzRuc0ZwuNRunLya8qz+PY3Gs5Xe9bwbmHs0eNE=;
        b=eDFAS1/KI9J0KqCcYWx+qq9o1/cnsO+tyZfnqdPbSRa2l2eidbuQkER33wg5h8X74GAXi9
        xW2cU9SUOKDpgK/hKZNGfMfrI+tYmNzXDX/chxMWqHUCuEAbhTy5H+0NooUrsXB3H/xURN
        KpzIOHEpJUAFQl+XKMSTP2AHJ4DUcD1k3v8P+fNQ+on8RJfOdOmJ/YmRW74RQ9aHrlpZN7
        UNLK7BMN27JA6mV/T62AkmTRVcpE39mNOdsxrfMX50eZOzb4dotYjJobqwHldPGSAQWQVS
        qEIX9viWcaft7/Oi1wlR5OH5iijZ935XlU0fa1YsmP9M/0zmrX/I8Gc54nYCew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598459384;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jM1CwzRuc0ZwuNRunLya8qz+PY3Gs5Xe9bwbmHs0eNE=;
        b=wLWQqKjVzO3vLj915fn6bfYiGeAJXzmodAS/hIh2lA5yGin2A59dpHwoNLVa9EcgbE3HM3
        X8o+R/TCDoSI6DAg==
From:   "tip-bot2 for Steve Wahl" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] MAINTAINERS: Add entry for HPE Superdome Flex (UV)
 maintainers
Cc:     Steve Wahl <steve.wahl@hpe.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200824221439.GA52810@swahl-home.5wahls.com>
References: <20200824221439.GA52810@swahl-home.5wahls.com>
MIME-Version: 1.0
Message-ID: <159845938349.389.3215010202341830050.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d4f07268d035721dd055ceb0de98ace6ac5f858b
Gitweb:        https://git.kernel.org/tip/d4f07268d035721dd055ceb0de98ace6ac5f858b
Author:        Steve Wahl <steve.wahl@hpe.com>
AuthorDate:    Mon, 24 Aug 2020 17:14:39 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 26 Aug 2020 18:24:43 +02:00

MAINTAINERS: Add entry for HPE Superdome Flex (UV) maintainers

Add an entry and email addresses for people at HPE who are supporting
Linux on the Superdome Flex (a.k.a) UV platform.

 [ bp: Capitalize "linux" too :) ]

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200824221439.GA52810@swahl-home.5wahls.com
---
 MAINTAINERS |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b0a742c..4c8a682 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18873,6 +18873,15 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
 F:	arch/x86/platform
 
+X86 PLATFORM UV HPE SUPERDOME FLEX
+M:	Steve Wahl <steve.wahl@hpe.com>
+R:	Dimitri Sivanich <dimitri.sivanich@hpe.com>
+R:	Russ Anderson <russ.anderson@hpe.com>
+S:	Supported
+F:	arch/x86/include/asm/uv/
+F:	arch/x86/kernel/apic/x2apic_uv_x.c
+F:	arch/x86/platform/uv/
+
 X86 VDSO
 M:	Andy Lutomirski <luto@kernel.org>
 L:	linux-kernel@vger.kernel.org
