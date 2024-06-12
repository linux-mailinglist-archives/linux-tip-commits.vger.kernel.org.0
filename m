Return-Path: <linux-tip-commits+bounces-1388-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B285905CCC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Jun 2024 22:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2D12880A8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Jun 2024 20:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AE212C7E3;
	Wed, 12 Jun 2024 20:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xvL+FUDe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z3uQABTJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DDD85C52;
	Wed, 12 Jun 2024 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718223871; cv=none; b=TMYpS520T+zb1D2vRUCrmQ4UCLZVP/4kL9ltwpc5gszxs73P7cGCY2Pnuq0uopV0Ni4Vvp/+X0N2LOEB9o5gf3xWwfOIWAvIm3YMqsNnI1w52eBjIVNM+3lFatGd9EsPQjb7t1veXtZQuU0AcWXrsruPOupGY7dtZGaVEqGyizE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718223871; c=relaxed/simple;
	bh=a6q28AfeY7KKsG2kG9Y11B99G/UZQtSlNTUmM44t9SM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a40SSTMhffW6RLEzh8UbB40zJfwfivAU/KDQe/gsH/iM1hxEcloCpVe6TtjMMcr9DWESO//gCNc+7fPOJ+WavCi3eRfdQKlss6bipIHjxuEfSWoLFFeDbKk6zAhE+H3BydsAF406bytJH456j+LBP499+Lr6tq1vEB1jiC0mK6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xvL+FUDe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z3uQABTJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Jun 2024 20:24:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718223865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQ4ky/PCh98PHFGcwPPXctHrV5/zfTg4rHhdQPuVmv0=;
	b=xvL+FUDeAMImcjceUWpclYnLD9KmIzimqKefUItXhK4x7tMnIFcKftMEqZ34VNCKKmkCHy
	pl17J3FQ6XREPuSROw1cLXoczSPVMwOW5xSuCYeDxWG073HcGLzqM3NQGutVBHxm4FF22U
	VNHVoVTrhm6LDpyJvJm+Ywqu+HoG6GQ5q2HgrNdYoLdUmzEhNlDdKGgIE99P/LwVihOqux
	NShz5EC4n8U6FBfoTjmds7fMpYvyQ9ki6EkFq7ItFGIAPV9WtXijH6g7HB+QPqUzc0TKuj
	QX4QyOJqDZpv8M/w1ifTyvMIgBsk2UExgVesI1eSIe2vAvENdOlqKQjz4aQqCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718223865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQ4ky/PCh98PHFGcwPPXctHrV5/zfTg4rHhdQPuVmv0=;
	b=Z3uQABTJoA2dgjP/fjxqYO+bxDQATAuXPOWZU8Hye7MQB3E63EqrJ88aiDUw3mWtidxUpS
	obvLYdyCjzzd6/AQ==
From: "tip-bot2 for Marcin Juszkiewicz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/misc] x86, arm: Add missing license tag to syscall tables files
Cc: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240229145101.553998-1-marcin@juszkiewicz.com.pl>
References: <20240229145101.553998-1-marcin@juszkiewicz.com.pl>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171822386538.10875.13561552354845428931.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     9aae1baa1c5d8b7229b6de38dc9dc17efcb8c55d
Gitweb:        https://git.kernel.org/tip/9aae1baa1c5d8b7229b6de38dc9dc17efcb8c55d
Author:        Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
AuthorDate:    Thu, 29 Feb 2024 15:51:00 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Jun 2024 11:33:45 +02:00

x86, arm: Add missing license tag to syscall tables files

syscall*.tbl files were added to make it easier to check which system
calls are supported on each architecture and to check for their numbers.

Arm and x86 files lack Linux-syscall-note license exception present in
files for all other architectures.

Signed-off-by: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: linux-arm-kernel@lists.infradead.org
Link: https://lore.kernel.org/r/20240229145101.553998-1-marcin@juszkiewicz.com.pl
---
 arch/arm/tools/syscall.tbl             | 1 +
 arch/x86/entry/syscalls/syscall_32.tbl | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 2ed7d22..23c9820 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
 #
 # Linux system call numbers and entry vectors
 #
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 7fd1f57..9436b67 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
 #
 # 32-bit system call numbers and entry vectors
 #
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index a396f6e..129bdd4 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
 #
 # 64-bit system call numbers and entry vectors
 #

