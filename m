Return-Path: <linux-tip-commits+bounces-3116-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F989FBB9C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 10:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12BF11695E1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 09:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17F81B21A7;
	Tue, 24 Dec 2024 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f9s0x4Qx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mVxaI1A2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BD21AF0B5;
	Tue, 24 Dec 2024 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033696; cv=none; b=KVXiRwcL5r30P9LzH8abuEPk12qf9HzDvkl5RYOSaAKGeMHw8hsAKor/AjYJVZ8ua6G2C0LK7yEf8mOnrpdDVFyRy1lJW7wVFnK4GV4sjDjGXfjgrdsifUTbGJ5zzHtR8vD1M7H6Dn62F1CiSgjUKZ94wIURxCJ7EuV1bxeb8zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033696; c=relaxed/simple;
	bh=UfQG4th2b7UOsQVZpiHKcCkHsh/o4ErAKYSlG4FuMG0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LuzLyg/Hcb7IGZU5ZEVqkz9dBFqd9b0/v9Jm0TtWULuwF4aQspdusj7z4yeQi6WbD12zeIpMFx0QNrS4QrqL772+kRcWQKTOBYU6ihW4rlvj3gHIADL+pwQOJipoHl0pvOupdUFnIpnhks0smAt3D2DUidJDo20XAbEQ81MT3QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f9s0x4Qx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mVxaI1A2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 09:48:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735033693;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONuniauDrdhlhSkGOivljKPK+iNSaceEcleG7P4qHm8=;
	b=f9s0x4QxJ08BDTe25jLKNSyERUBjRMjbeCLolrdkdqC9roIvqRia7uyCAp7dwvY1shfDCY
	pZpXxTPPjI4b1mgwwPrdlLBx2XJnrP3scZFDlFLCVJHgeFCtbr7FSPqJm4Ac0vEUPRmfFI
	6Hrb8snnnIsEgy6ycoVaOBzUJyP8s15jectfRlfKpvvwoqmKoSjaVouKU8T0qrKTayC7v4
	UjzxoGsFEwYGUea7iPhdWD86HsfGP1roHAn0QwfITdEiQJLTUN1K1bSDt+d3vnKbmRiEFE
	GCC7K0F3mUVgf6ggGc3HltL/dYornSK2LaA1YUtXH+L++PPHOdHkvWcLJFsYbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735033693;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONuniauDrdhlhSkGOivljKPK+iNSaceEcleG7P4qHm8=;
	b=mVxaI1A2jopcmqaFicd15m6CBylm6Da6I3XbvrpqBZquGjuX4GbEZMIjBDgd+1oUKu6FW8
	uaywONqgtKULJqBg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Remove unnecessary include of <linux/extable.h>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241220084029.473617-1-bigeasy@linutronix.de>
References: <20241220084029.473617-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173503369309.399.9530561273620366379.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     aa135d1d0902c49ed45bec98c61c1b4022652b7e
Gitweb:        https://git.kernel.org/tip/aa135d1d0902c49ed45bec98c61c1b4022652b7e
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 20 Dec 2024 09:40:29 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 20 Dec 2024 10:26:27 +01:00

x86/mm: Remove unnecessary include of <linux/extable.h>

The header file linux/extable.h is included for
search_exception_tables(). That function is no longer used since commit:

  c2508ec5a58db ("mm: introduce new 'lock_mm_and_find_vma()' page fault helper")

Remove it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241220084029.473617-1-bigeasy@linutronix.de
---
 arch/x86/mm/fault.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e6c469b..ef12ff3 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -7,7 +7,6 @@
 #include <linux/sched.h>		/* test_thread_flag(), ...	*/
 #include <linux/sched/task_stack.h>	/* task_stack_*(), ...		*/
 #include <linux/kdebug.h>		/* oops_begin/end, ...		*/
-#include <linux/extable.h>		/* search_exception_tables	*/
 #include <linux/memblock.h>		/* max_low_pfn			*/
 #include <linux/kfence.h>		/* kfence_handle_page_fault	*/
 #include <linux/kprobes.h>		/* NOKPROBE_SYMBOL, ...		*/

