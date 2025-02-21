Return-Path: <linux-tip-commits+bounces-3594-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 731BBA40234
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 22:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A35942697E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 21:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E302500BC;
	Fri, 21 Feb 2025 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q2lNGBEj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wdd1cYF/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F58253B7C;
	Fri, 21 Feb 2025 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740174090; cv=none; b=q7BpmotRF6u6VencxsvvolbaHxUGiMSGowUeQqqqUon6+x6WDKnhBp7HMnSrCcBPdFs95peJepGUDeyryX2DPA5eFUApBOR/OjFc3xHLUHmj/0H+WIMztXNHYlfLQMnE2U2iTPBfkKLBfl/GvS1DR7UU4tZeplO7TftGND90Tvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740174090; c=relaxed/simple;
	bh=ZR7BagWzxCfoY5xdXeUMysXR0SHla1vmdjofsLVak4Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T3aVi2UgFE5o6R7B5AChobCZlCYL4S3ewRrC18B5DHBFmrGtVDxJ08PJkikG3QZi/wf3ek9OxB2hiDqi8uJoYK4nJi/UhgdTTyyUjU/1/xPESe9fpI0nShLhFO7h7QNTdZjb8VY87EfjKy1G0BoXST9kNlBsTBmLqqTQkLTHoL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q2lNGBEj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wdd1cYF/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 21:41:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740174086;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRPjxDl2DX3wCxuayZ+2UBpjqpVk0QUoy0ydWEghp6M=;
	b=q2lNGBEj39/Kqhl3Mfa/K0jmXvX2tsWYNSSfKY2KE5HNImKkmX1UYIkW6vTzXwRfoevFwu
	9V03UYB8CY5ABRPxgfqFYUlfKHEJbJwG22Z8pUfNK8CcnQ6x9s/m2LiBQYXR3QLy4n6bHw
	Lxsmsh5XRe98JGHw51gmcm3Dz1SHb57HKgRvWCLiDNsqQTgn0ggb3MHxh3OEp9xc5lfVdD
	MXjcHNUylZsBc88NHZzdb/h88cDSH4aHaZvcWwfbwqaV9AYaptmV1AXEF8F0b+Wy2zPlJH
	HnLpMZgzwF2LCDqtH8fPUPF/fduSw2RUobRb506yDIzjf8o4Bb7SnUWt0F2SZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740174086;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRPjxDl2DX3wCxuayZ+2UBpjqpVk0QUoy0ydWEghp6M=;
	b=Wdd1cYF/oDugCPKVr2Lg3SFpy5XNMjAB0PNYniZBuhXFg3/8CX0BUGUVuY6upAraFnNZcC
	FQiRTM8dZLMVWuCQ==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/arch_prctl/64: Clean up ARCH_MAP_VDSO_32
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250202202323.422113-3-brgerst@gmail.com>
References: <20250202202323.422113-3-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174017408231.10177.16299420907138004012.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     684b12916a107157633311f07bb74307221eff92
Gitweb:        https://git.kernel.org/tip/684b12916a107157633311f07bb74307221eff92
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Sun, 02 Feb 2025 15:23:23 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 22:32:25 +01:00

x86/arch_prctl/64: Clean up ARCH_MAP_VDSO_32

process_64.c is not built on native 32-bit, so CONFIG_X86_32 will never
be set.

No change in functionality intended.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20250202202323.422113-3-brgerst@gmail.com
---
 arch/x86/kernel/process_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index e067c61..4ca73dd 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -942,7 +942,7 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_MAP_VDSO_X32:
 		return prctl_map_vdso(&vdso_image_x32, arg2);
 # endif
-# if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
+# ifdef CONFIG_IA32_EMULATION
 	case ARCH_MAP_VDSO_32:
 		return prctl_map_vdso(&vdso_image_32, arg2);
 # endif

