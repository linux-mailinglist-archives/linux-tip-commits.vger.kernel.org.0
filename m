Return-Path: <linux-tip-commits+bounces-4214-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B9BA61C03
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 21:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A46927AFAB4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 20:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5421C204F9D;
	Fri, 14 Mar 2025 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QH8GqYVj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ezeCYSJi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA41204F93;
	Fri, 14 Mar 2025 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982644; cv=none; b=AupV+bzOKy2iSGRCLXVkbGWJseZcLS4IhoMiivDNOl9IFctpQBsYWOchxGfg0QySPQtRqX9S02zqOMaO1YLdcVYecx18ZF947PbxXzoP/Hbsvzwb5tDoVoriYOsOb+nq/ZpoZFsqhHDxbC27w0XjvQSq15BRyToAU478DzVCwlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982644; c=relaxed/simple;
	bh=6fl19qt8uRo7rVlCXhkBK8V5Sevp1OWU//aOfS+PLCU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IRxJT4HqbStvEF1OgvoRL8MkosQKsmklr7Cs2RnfwIlj9LGAmEmPEiQVxIgfwaythXOOSEDL1yTeCbwwqBb577UYfpGwGkX0bpwlY2SqJ3x0KsAqnhQuuCBZgRrA1WMVhsW4/pMAjWPnwfs8e0JjzvYr+Vip2Z3lzjP9ooBrqcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QH8GqYVj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ezeCYSJi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 20:03:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741982640;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zo1iE4mmcJfK6JAhDZYn2eC23iWPOwtDxs1bIqYZJ0=;
	b=QH8GqYVja7uYmQs6UFDkCmL3J46luuHokbygzwQqLF/InOuIh//GYDxSMEzki/2nWbId47
	aL16qeH8DHFlEcSqCUxiAadhsIQUykIyV2/QBgge9OaUlKQed8JuJAdmHxQUo+fS1hEzw6
	LywYRHIrWixnkbTFh7pxQTogxapYwLwxIpfsBESY/LkN6a084SY5XqrNSLniZuKXmpgSp3
	TjpPcpdADfjXw761jb53+96D0vM22OtHinoH/bEQqqfW4HyvLSTj1hkNmN9bPBwRr/wj4s
	BChIbYWLOMtQxjvq0zRu7smd7XHuoYvCL8wzq8KnkIIYrJf8YBflTo1uQnTfRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741982640;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zo1iE4mmcJfK6JAhDZYn2eC23iWPOwtDxs1bIqYZJ0=;
	b=ezeCYSJiz1zU0eNjPcK341JDsQtAV9PZqZeuOXVz4b3QcFyQyXk61UX84wgjvjW7SUuZIO
	KvTpXz4hIapLo6DA==
From: "tip-bot2 for Tiezhu Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] LoongArch: Enable jump table for objtool
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241217010905.13054-8-yangtiezhu@loongson.cn>
References: <20241217010905.13054-8-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174198263615.14745.12782989496753781204.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     e20ab7d454ee8d1e0e8b9ff73a7c87e84c666b2f
Gitweb:        https://git.kernel.org/tip/e20ab7d454ee8d1e0e8b9ff73a7c87e84c666b2f
Author:        Tiezhu Yang <yangtiezhu@loongson.cn>
AuthorDate:    Tue, 17 Dec 2024 09:09:03 +08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 12 Mar 2025 15:43:39 -07:00

LoongArch: Enable jump table for objtool

For now, it is time to remove -fno-jump-tables to enable jump table for
objtool if the compiler has -mannotate-tablejump, otherwise it is better
to remain -fno-jump-tables to keep compatibility with older compilers.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Link: https://lore.kernel.org/r/20241217010905.13054-8-yangtiezhu@loongson.cn
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/loongarch/Kconfig  | 3 +++
 arch/loongarch/Makefile | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 2b8bd27..15aaa2e 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -291,6 +291,9 @@ config AS_HAS_LBT_EXTENSION
 config AS_HAS_LVZ_EXTENSION
 	def_bool $(as-instr,hvcl 0)
 
+config CC_HAS_ANNOTATE_TABLEJUMP
+	def_bool $(cc-option,-mannotate-tablejump)
+
 menu "Kernel type and options"
 
 source "kernel/Kconfig.hz"
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 567bd12..0304eab 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -101,7 +101,11 @@ KBUILD_AFLAGS			+= $(call cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)
 KBUILD_CFLAGS			+= $(call cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)-mthin-add-sub)
 
 ifdef CONFIG_OBJTOOL
-KBUILD_CFLAGS			+= -fno-jump-tables
+ifdef CONFIG_CC_HAS_ANNOTATE_TABLEJUMP
+KBUILD_CFLAGS			+= -mannotate-tablejump
+else
+KBUILD_CFLAGS			+= -fno-jump-tables # keep compatibility with older compilers
+endif
 endif
 
 KBUILD_RUSTFLAGS		+= --target=loongarch64-unknown-none-softfloat -Ccode-model=small

