Return-Path: <linux-tip-commits+bounces-4606-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 508ACA77509
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 09:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68D8169496
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 07:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF70E1EB1BA;
	Tue,  1 Apr 2025 07:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bUWeTO+6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GBuCTCuw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ACA1EA7EC;
	Tue,  1 Apr 2025 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743491725; cv=none; b=kIx2ABIXE+hHsPlQkit5U1/WsaL5RpOYLKM1iv7jo3Xzw5NcjXr4obg26Ie3060J9zjpDm2g8ZBdjBLwjTCtWdFsROKLlKfCuukDBjQniMactxT0XDJUBWcR9NUeCcZ2C/yzckrkIQi9KYTxaztlPtYq+YgwFCWZQkyDQDtoZv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743491725; c=relaxed/simple;
	bh=z3MaCi8YKdHu4c/oMrICwPVkiohHTWq1bDjaEYjqm7I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SJCurwzM3fFw9N3MuKi2SoGuB4A+3wsJeqepvchDM2cKQqyzsJoSbpOKqvd1kiZIP11t1tmxD2Tz1T2jKKV4rWxOTY9zaRQkMhZo6Nc+0f1hs1uzvq7MKcfdIBy64TSu85U/aHL3HSYcwEdtOPfe1O8d4Q2fW2wgUe6TZltISWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bUWeTO+6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GBuCTCuw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Apr 2025 07:15:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743491722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6P2yP9Kg6vDlfxg4cCFX9K0zZiQcxGCJ3MjTtahy3HY=;
	b=bUWeTO+6lcSD07ZLU+v/qYySxK5XIhTniQAtoN6znejoLlAEcznwUcSCgNT73R2CeRy6G8
	RriKtzxZHGyIth3FOdF0zOivnGVoccTLySKOs+BQZ8hmwlv9pGlHjNqrZBBQMm2h+mc+pk
	EfUHT8VSHernpcQcNKmf+Fda/yq31ibxWREREif5gTdxXUrYGHh+8yYdyaD6LgbRwQmgBk
	fkjoPl3noVOkExqAMQRtivOr9KK4vo3aOCfPTvkwxFcfXsX2/wp94dPySoEiIt7KoBt+tJ
	1T+Bjtk+6xwSzAequIwPkelqF5pIPwZsvuLZ3R7irQ2j/qae5tvk6pE4Kmbm2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743491722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6P2yP9Kg6vDlfxg4cCFX9K0zZiQcxGCJ3MjTtahy3HY=;
	b=GBuCTCuwmqNXHUOIaPyZOdYA8tR+hGHYT/AAPWqs2QvNxrun8inBZKPvSRQudR9wdm3w+t
	UZPQdbX1sCZqC/Ag==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Silence more KCOV warnings, part 2
Cc: kernel test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <a44ba16e194bcbc52c1cef3d3cd9051a62622723.1743481539.git.jpoimboe@kernel.org>
References:
 <a44ba16e194bcbc52c1cef3d3cd9051a62622723.1743481539.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174349172182.14745.15104179899500326383.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     55c78035a1a8dfb05f1472018ce2a651701adb7d
Gitweb:        https://git.kernel.org/tip/55c78035a1a8dfb05f1472018ce2a651701adb7d
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 31 Mar 2025 21:26:36 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 09:07:12 +02:00

objtool: Silence more KCOV warnings, part 2

Similar to GCOV, KCOV can leave behind dead code and undefined behavior.
Warnings related to those should be ignored.

The previous commit:

  6b023c784204 ("objtool: Silence more KCOV warnings")

... only did so for CONFIG_CGOV_KERNEL.  Also do it for CONFIG_KCOV, but
for real this time.

Fixes the following warning:

  vmlinux.o: warning: objtool: synaptics_report_mt_data: unexpected end of section .text.synaptics_report_mt_data

Fixes: 6b023c784204 ("objtool: Silence more KCOV warnings")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/a44ba16e194bcbc52c1cef3d3cd9051a62622723.1743481539.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/oe-kbuild-all/202503282236.UhfRsF3B-lkp@intel.com/
---
 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index b935974..4d54305 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -275,7 +275,7 @@ objtool-args-$(CONFIG_MITIGATION_SLS)			+= --sls
 objtool-args-$(CONFIG_STACK_VALIDATION)			+= --stackval
 objtool-args-$(CONFIG_HAVE_STATIC_CALL_INLINE)		+= --static-call
 objtool-args-$(CONFIG_HAVE_UACCESS_VALIDATION)		+= --uaccess
-objtool-args-$(CONFIG_GCOV_KERNEL)			+= --no-unreachable
+objtool-args-$(or $(CONFIG_GCOV_KERNEL),$(CONFIG_KCOV))	+= --no-unreachable
 objtool-args-$(CONFIG_PREFIX_SYMBOLS)			+= --prefix=$(CONFIG_FUNCTION_PADDING_BYTES)
 objtool-args-$(CONFIG_OBJTOOL_WERROR)			+= --Werror
 

