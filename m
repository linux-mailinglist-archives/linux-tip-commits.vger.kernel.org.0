Return-Path: <linux-tip-commits+bounces-3682-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292B0A4607C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 14:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF293A53BE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 13:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B2142A8B;
	Wed, 26 Feb 2025 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b2PQexC2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4E5GYjNI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A367464;
	Wed, 26 Feb 2025 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740575746; cv=none; b=CwZ7SKwlCnils+sfsrzPe2bWkHKkzVcfF6rLhBddPZzAGqAgebHg/bEqRJVXrJU5+1rFqZKXOrAY0uFNyZkFOZSamerUatO5YASskrFGCP3fF2Ik8+q7NdWEP9DbtpbqHxyU8z0cdTTXlwlrVJ8fT4IOjoO9JllOs2Ykeyz/mis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740575746; c=relaxed/simple;
	bh=FkgBNwq3LD9oQuZdQNKEH0bzz4rhSH5WEeCocjsWtrM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r6Vl4/v27zCLcQC7OXm8FnNu7S6Xx6vuQQcLFKVm/AbBnVPiKrgKS3wbBJBCGtlFRYByhBKamJ+WmjOkuvvdvnFaSUCMYa3bADAMnnkEFEEnXDZC2XuGs31vwg5yyLm9OSe/dK8yHH4FFlcZJCJboDGlyRG/88Nf/wusH0MMeio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b2PQexC2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4E5GYjNI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 13:15:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740575742;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eX/KYuODbm+Wqb3zKAhEP8DFi6hUGDg1DsHJjBmleWA=;
	b=b2PQexC20YDn0CGYYEgQ3nxa2RJ6po88J3yoEwpqL7nCU6oqwVu9DKp7kVv2iXwKBD15Eq
	FuvVE6SDClvshtuk6slMotXtDvkYt0o124PauKjFDS8evnp5GiYxUhqP0u/v9Bdep/xkXb
	IciA/hVfdp/J8fON0KG+EeP8Q49jqysxP1pjQIcLowr64beSymZd7LbKoJ+ZpNjGFU++Bb
	3f+0mEJJMcxVZqRspz2iO6Vqx9yfmzooQ3nYJyVm7xcsOG7lIeS0r3bgSJwl5rOHmepbzQ
	UXfkFeGXRxGaq17mO9o+/3+bcyiruK0X5SzDyRquSixTaDj7dDon8ihBsYEFNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740575742;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eX/KYuODbm+Wqb3zKAhEP8DFi6hUGDg1DsHJjBmleWA=;
	b=4E5GYjNIaujoWNsCpnjnY4kS5KB3wu+QS6qX7yCI7l7Y8oX8B20qOrnuJuebKNIh58nInm
	bLRyKXxcoAIlY8Dg==
From: "tip-bot2 for Benjamin Berg" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fpu] vmlinux.lds.h: Remove entry to place init_task onto init_stack
Cc: Benjamin Berg <benjamin.berg@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241217202745.1402932-2-benjamin@sipsolutions.net>
References: <20241217202745.1402932-2-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174057573055.10177.16342574148901727326.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     2ec01bd7152f80795eab7b48706aa5db8d4a286a
Gitweb:        https://git.kernel.org/tip/2ec01bd7152f80795eab7b48706aa5db8d4a286a
Author:        Benjamin Berg <benjamin.berg@intel.com>
AuthorDate:    Tue, 17 Dec 2024 21:27:43 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 14:02:21 +01:00

vmlinux.lds.h: Remove entry to place init_task onto init_stack

Since commit 0eb5085c3874 ("arch: remove ARCH_TASK_STRUCT_ON_STACK")
there is no option that would allow placing task_struct on the stack.
Remove the unused linker script entry.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241217202745.1402932-2-benjamin@sipsolutions.net
---
 include/asm-generic/vmlinux.lds.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 02a4adb..a1b0469 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -404,7 +404,6 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	__start_init_stack = .;						\
 	init_thread_union = .;						\
 	init_stack = .;							\
-	KEEP(*(.data..init_task))					\
 	KEEP(*(.data..init_thread_info))				\
 	. = __start_init_stack + THREAD_SIZE;				\
 	__end_init_stack = .;

