Return-Path: <linux-tip-commits+bounces-1273-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BF58C9ADD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 20 May 2024 12:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFAFA1F214EE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 20 May 2024 10:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F864D59E;
	Mon, 20 May 2024 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UoJDF7bD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wol5Ib6P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B871A2D;
	Mon, 20 May 2024 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716199196; cv=none; b=nHUb4QUXLx+ajrJaf/02vaXvBfBe2yxJ5komNvhm6cKilMBiu99514b0Q6gGZCiBxtYX2ul4DEe9okdHqrSYyQXoCJMab7YcqHqZXguoi3GLi/TYSmFvx+8ksHPRnyaPk03MPUBNneeA9RlDyrRrErAlhM5MH8biiteM/okqX+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716199196; c=relaxed/simple;
	bh=jLOdgazjiiTdRmUD81SHTdZCwonsG+vVDmIptdjPZOg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VRJC8EaklG1DOf1F6bbLXKC9eaR7vnowmY1yQ5414fUHQn5WKM9M8W46DMFyCc5UrtPrzDvSSWUA500EQfhXR5nm0CgN+bjXVgoa8axHO01CyHh4+tCVGRVIJm8+LAeWwpUXUrdU0z9HwAki7VUiMN6HUlKonh7wj9FPmXvC+vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UoJDF7bD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wol5Ib6P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 20 May 2024 09:52:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716198729;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1N9+Qdwz8AdQfydLx/OfIe37pEhj7V/SohKPZyrId8=;
	b=UoJDF7bDv5/FtV5JlQlh2f2ch/gDlxHR79KZ1DQcEtZkN+iKc1srq2bwkOy7c3ZO8XSY6N
	a/k2O3na02tzoZ0rMYS7sOfuhFY7aijYDdcFXwd9ZPTYgsGVOaCk8mTZ3yagFmpVskO/bz
	54olCcpu18lcg1SYDZhBjC6r2ykbiFGfmFCxD5Pr1wBm1ILogKfeZ70+/Q1mQbNCAbN7C8
	sXTXowMdFASzhy3JReLrNS00EEqrfpPaYe0lEL6TLL78uS1L/5KfHserAgxADCdocJ3gyt
	1jVY6/AAk0Xi0gFpyBEPTVYoKKQbH0Nd3UZZXY8wG/vSlTcNMUtKtVUFSqCU4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716198729;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1N9+Qdwz8AdQfydLx/OfIe37pEhj7V/SohKPZyrId8=;
	b=Wol5Ib6PpYTls7ZdFlo24QEkkqqjcUAaUe7Ua4Jw4WxC1wIXIpiUiNvNCFXrER7FRM/A+8
	Tu5hsrI3OhkPbVDA==
From: "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/kconfig: Select ARCH_WANT_FRAME_POINTERS again
 when UNWINDER_FRAME_POINTER=y
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240204122003.53795-1-masahiroy@kernel.org>
References: <20240204122003.53795-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171619872839.10875.9967455502104186005.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     66ee3636eddcc82ab82b539d08b85fb5ac1dff9b
Gitweb:        https://git.kernel.org/tip/66ee3636eddcc82ab82b539d08b85fb5ac1dff9b
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Sun, 04 Feb 2024 21:20:03 +09:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 20 May 2024 11:37:23 +02:00

x86/kconfig: Select ARCH_WANT_FRAME_POINTERS again when UNWINDER_FRAME_POINTER=y

It took me some time to understand the purpose of the tricky code at
the end of arch/x86/Kconfig.debug.

Without it, the following would be shown:

  WARNING: unmet direct dependencies detected for FRAME_POINTER

because

  81d387190039 ("x86/kconfig: Consolidate unwinders into multiple choice selection")

removed 'select ARCH_WANT_FRAME_POINTERS'.

The correct and more straightforward approach should have been to move
it where 'select FRAME_POINTER' is located.

Several architectures properly handle the conditional selection of
ARCH_WANT_FRAME_POINTERS. For example, 'config UNWINDER_FRAME_POINTER'
in arch/arm/Kconfig.debug.

Fixes: 81d387190039 ("x86/kconfig: Consolidate unwinders into multiple choice selection")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20240204122003.53795-1-masahiroy@kernel.org
---
 arch/x86/Kconfig.debug | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index c5d614d..74777a9 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -248,6 +248,7 @@ config UNWINDER_ORC
 
 config UNWINDER_FRAME_POINTER
 	bool "Frame pointer unwinder"
+	select ARCH_WANT_FRAME_POINTERS
 	select FRAME_POINTER
 	help
 	  This option enables the frame pointer unwinder for unwinding kernel
@@ -271,7 +272,3 @@ config UNWINDER_GUESS
 	  overhead.
 
 endchoice
-
-config FRAME_POINTER
-	depends on !UNWINDER_ORC && !UNWINDER_GUESS
-	bool

