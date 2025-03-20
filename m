Return-Path: <linux-tip-commits+bounces-4410-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26563A6A20A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Mar 2025 10:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AAAD467E93
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Mar 2025 09:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245AA1B0405;
	Thu, 20 Mar 2025 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cUmkhvs8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="350RVoBT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48659207A03;
	Thu, 20 Mar 2025 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461269; cv=none; b=Vp4SHQWjwqhTMJspsvfr0Q60xaSprs0iDDWvWyYau4sUZoO1GU/DAUjjzNCaZaZguwbom5AFHoLjpsDvygHlHh6mH7mQuw3ZjxabFhccNOyVfMQ/UWYKEemPHIEkG3RxWAEH1aHOphmIhBLBEK6fgl00tthKujhrkt4xilDrZhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461269; c=relaxed/simple;
	bh=ZT0sJ+5w47IhNip0vZsoB41Y6n9mv1fmc5It9kaFzlM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RP4m+PKtFExAdvzoTrF7z9lHwqk5isU/BcR+UnfneYeHDPEQtI3z2ErMS+yUI+9PSW14rxclvlhfJnuUHOtm5NmSJOIaAAvmSTAnT4tZNkjVKtL3ZcHkVgtR2TJueylylZk5lF6pYNoZGjUN1yub88BR2/Sjvd5yOSyxBO6sBVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cUmkhvs8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=350RVoBT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Mar 2025 09:01:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742461265;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6CFUzOF+hwdOfS46KtEoCc3LXrvdoQndwZimkD2TQRw=;
	b=cUmkhvs8pmZ9uLj7kFYsSIo2W45xkuz1sSgni1CMIslbdJQFlgLEPdNYBlSSitmzoYi8kK
	iAKHu9qJPlq/mklqjI+4GYEUDELsg7vIc9HjR/AntBt1lZn+O4ldL7c0uRWd9yJduZDsSI
	BVB8PntaWNkhW+PcDmkdmq9xsWdFdvUmICUObRD8A4IN71R72gNIMR+Rl35ipvj7gsyHhU
	0OhAi9UkiQrnEgTVZ5xOUcf/CePOGH6HY3kqEdvtOSsqcBDXO/0wtjF/Y/kiWfbH1CWcgE
	5Yyqla9410KbrvjNE7Zl1x1limy+RgzaPSI47ySd5QX42G/FMjJTMQw/PzVW/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742461265;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6CFUzOF+hwdOfS46KtEoCc3LXrvdoQndwZimkD2TQRw=;
	b=350RVoBTGnR0wQoMjb2R0fsxEjZg80Bx7Aov2Sf1y5apkYcHCNFzNfc6cBw0b51Y4j6FDc
	ddHZBMBDhO6SMhAg==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] gendwarfksyms: Define __GENKSYMS__ when processing
 <asm/asm-protoypes.h>
Cc: syzbot+06fd1a3613c50d36129e@syzkaller.appspotmail.com,
 Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, Brian Gerst <brgerst@gmail.com>,
 Uros Bizjak <ubizjak@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250320070746.101552-2-ardb+git@google.com>
References: <20250320070746.101552-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174246126447.14745.7024307702923339978.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     fb3135208f688c5cab7d05e3a0d229935ee7611a
Gitweb:        https://git.kernel.org/tip/fb3135208f688c5cab7d05e3a0d229935ee7611a
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 20 Mar 2025 08:07:47 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 20 Mar 2025 09:48:49 +01:00

gendwarfksyms: Define __GENKSYMS__ when processing <asm/asm-protoypes.h>

Ensure that __GENKSYMS__ is #define'd when passing <asm/asm-prototypes.h>
through the compiler to capture the exported symbols. This ensures that
exported symbols such as __ref_stack_chk_guard on x86, which is declared
conditionally, is visible to the tool.

Otherwise the build might break when CONFIG_GENDWARFKSYMS=y:

  <stdin>:4:15: error: use of undeclared identifier '__ref_stack_chk_guard'

Reported-by: syzbot+06fd1a3613c50d36129e@syzkaller.appspotmail.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: syzbot+06fd1a3613c50d36129e@syzkaller.appspotmail.com
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20250320070746.101552-2-ardb+git@google.com
---
 scripts/Makefile.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 993708d..7855cdc 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -305,6 +305,7 @@ $(obj)/%.rs: $(obj)/%.rs.S FORCE
 getasmexports =								\
    { echo "\#include <linux/kernel.h>" ;				\
      echo "\#include <linux/string.h>" ;				\
+     echo "\#define  __GENKSYMS__" ;					\
      echo "\#include <asm/asm-prototypes.h>" ;				\
      $(call getexportsymbols,EXPORT_SYMBOL(\1);) ; }
 

