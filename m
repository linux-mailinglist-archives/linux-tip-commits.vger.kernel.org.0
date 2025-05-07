Return-Path: <linux-tip-commits+bounces-5414-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD48FAADB50
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B049A24A1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF85E243951;
	Wed,  7 May 2025 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4uiT9OlG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LccdkoYe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A0A242D8A;
	Wed,  7 May 2025 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746609345; cv=none; b=XxXejnCoWNzMTCKYMEQX3NmLKG+MeNPs9mtyi4Vi11TvC3jIMX/8XvgtxJklQzANFXy3SMlcVcOgPS5pfGAg3LE303imoISIBqesJGArNm1byUP7s8qI7+9JIHrmtbphqGfNIsFjsesTrKo5YgE1OMUmIC1EQ5VBMkzt9KfI3i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746609345; c=relaxed/simple;
	bh=Gdc73QPww2eaaTVo/yUAMen6YurJl2N5v8iST27Yngs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mdOtlCUPp2RCIhr3K8FNuBNRzalnL4gsR6Y3TVSqbAr28G9+zWfwcPbWKcupZ2e4Yu4urdtGMW3ULLAG9JOv5t9Pbw4B/GdLQtZFFFH3ul3UVBaWpusEwcEd+zplzTXH78kseX0p0f+hmtPBEurzWwPPY5Z+mRHkSgyYI2Jojvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4uiT9OlG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LccdkoYe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:15:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746609342;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSbHAP6myb/lvwCsvli/C7L3x86muzLYoyywPNFb690=;
	b=4uiT9OlG9MOhI9hZD+EDGL2AH8cPFgd84wG/IIN+3X4Ak04gFdl2M3bP02z+JHxeUrsFDT
	Bn9npQXTUL3tCplyPCyG3IUOEeVjZ8ndXKNPbBXQrsAkH4SXtmvZiO3zsMulAtrrH+laz0
	vjzihdkwwtCgQWU+GLNyaS5XxOsMQhXa9AybA1WncTEj3dLZzW1RpBAC0mggP1JngWdKCK
	IKerPRw6nmvLxcYg9tVTSmTM0nUvBwgil7jgwU/w0PTLlQLB5dNp9SQIZ40LIV7j3SBulE
	FvWjg3wBgB4Zea84NxOc8YfonI/4aOv0RQoHaE7QARQwfZa9c6KCIs8LG1tzZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746609342;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSbHAP6myb/lvwCsvli/C7L3x86muzLYoyywPNFb690=;
	b=LccdkoYe6e5qoyTbKt11C++Wf1JaJyuLrR4zVlqPd0YehYThP09ssbzhXVghNZjQA1XFrT
	W2PLIckpKird9gAQ==
From: "tip-bot2 for Charlie Jenkins" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] LoongArch: entry: Fix include order
Cc: Charlie Jenkins <charlie@rivosinc.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250507-loongarch_include_order-v1-1-e8aada6a3da8@rivosinc.com>
References: <20250507-loongarch_include_order-v1-1-e8aada6a3da8@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660934159.406.10042368786930832922.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     8278fd6006a02e3352d5230927c4576f53fb3b06
Gitweb:        https://git.kernel.org/tip/8278fd6006a02e3352d5230927c4576f53fb3b06
Author:        Charlie Jenkins <charlie@rivosinc.com>
AuthorDate:    Wed, 07 May 2025 00:11:30 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 11:05:57 +02:00

LoongArch: entry: Fix include order

Reorder some introduced include headers to keep alphabetical order.

Fixes: 7ace1602abf2 ("LoongArch: entry: Migrate ret_from_fork() to C")
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250507-loongarch_include_order-v1-1-e8aada6a3da8@rivosinc.com
---
 arch/loongarch/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index 98bc60d..3582f59 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -13,8 +13,8 @@
 #include <linux/cpu.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/errno.h>
 #include <linux/entry-common.h>
+#include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task.h>
@@ -34,8 +34,8 @@
 #include <linux/prctl.h>
 #include <linux/nmi.h>
 
-#include <asm/asm-prototypes.h>
 #include <asm/asm.h>
+#include <asm/asm-prototypes.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
 #include <asm/elf.h>

