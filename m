Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB38219C01
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jul 2020 11:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgGIJWx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Jul 2020 05:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGIJWx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Jul 2020 05:22:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0D0C061A0B;
        Thu,  9 Jul 2020 02:22:52 -0700 (PDT)
Date:   Thu, 09 Jul 2020 09:22:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594286570;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GX6BaDx6+2BIX5QeJzW8OP92f+lCoUYp89bEta19kcE=;
        b=dPGhUOjDGQeYwS+3zogxhBhOicCserPME254ni/yrT3y87yb0DUhI+KMJudK/DZJR5XdI4
        CWKyTWK5ymcru+Lz+0ECT4wqDndzLKS8GcIDuqgYPsNOlYgi5HOBTY9Uhs/uTyTBIC1vrL
        zPy2Dsk8u6phu6XfZf5BTVMoXbfqBu+lkGTunvmRtKVQnmiOGK/VU+jV6We5G2g38VoorB
        n8tnznceYVMQZuMG/ToRNkQ6eZzfLk/9FFAG6KIzDJgOj9b91w3IX3DxMSJayNZ57l97k6
        kfFUQSSpciNrWrcISVbeLOCTGC4f2Wq+xl7vtpUm0iVifzsgodBttkjrSnvFbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594286570;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GX6BaDx6+2BIX5QeJzW8OP92f+lCoUYp89bEta19kcE=;
        b=6llPMvYHa/RzNQl1ijr/RJx5yxhmP3LjYWez1105wSu2bbLuVNIq0nj4elJX4ilvW7S70I
        qSj5MBBai0p+03DA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry/common: Make prepare_exit_to_usermode() static
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200708192934.301116609@linutronix.de>
References: <20200708192934.301116609@linutronix.de>
MIME-Version: 1.0
Message-ID: <159428656978.4006.16608746546724198157.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     bd87e6f6610aa96fde01ee6653e162213f7ec836
Gitweb:        https://git.kernel.org/tip/bd87e6f6610aa96fde01ee6653e162213f7ec836
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 08 Jul 2020 21:28:07 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Jul 2020 11:18:30 +02:00

x86/entry/common: Make prepare_exit_to_usermode() static

No users outside this file anymore.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200708192934.301116609@linutronix.de

---
 arch/x86/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index ea7b515..f092884 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -294,7 +294,7 @@ static void __prepare_exit_to_usermode(struct pt_regs *regs)
 #endif
 }
 
-__visible noinstr void prepare_exit_to_usermode(struct pt_regs *regs)
+static noinstr void prepare_exit_to_usermode(struct pt_regs *regs)
 {
 	instrumentation_begin();
 	__prepare_exit_to_usermode(regs);
