Return-Path: <linux-tip-commits+bounces-2882-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9C99D9990
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Nov 2024 15:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936BF164CA1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Nov 2024 14:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233E11CB32A;
	Tue, 26 Nov 2024 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FnSXrwD2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MmIZHcEt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CF33398E;
	Tue, 26 Nov 2024 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732631110; cv=none; b=rzQjgxKMP1sTzC8ELvkwAq35p1/CfbyPE0bbyBxANGl9xz3Hb318VN/rwLKVeO7YPA89sFlabn21ZrmyP5S3bysDTmgwa0rCi94o4KxEK68/0748jWTz9c9GTBiR7aA+CCXQPzEmIqsaKI2cDd0CV24J3hbPczOq4Mzio4aaFjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732631110; c=relaxed/simple;
	bh=ZBVHJnPVFyOj8QosdJhPayaLotx+2VTGJuwtIsepeWk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kTCkMeygsDACpnYSCrfUGMT4Uf+Zcxxvu1bAhqlYW7o0/d/0i0qa72bFK+tq+F8F9aYAElKcvh/2A3SwTi5dpIsK/WMthunhlF/Bc5KSjKlDqbHzUDP6WppjB8K7PDk2q3zjDcoIp78rKYi5tzVXRktO8pUPdl7to8i9pMHVp7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FnSXrwD2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MmIZHcEt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 26 Nov 2024 14:25:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732631106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kCD1ZHjwz01Rbei/j//jE5hm6Kci+8lyaIpiJFEDpE=;
	b=FnSXrwD2n9F5l9xmIYJl+tFBYqRDoV1Op3tzX1eO9XIDSclNLdrD24oUl3AtGYWHJ8BzmA
	g2/ApYo3rLr+lIJqcj0sMRaOPn+ap38SrkeDh9I/X5/Moz5vzwWzGMsYVq8IhmYwl/rIUQ
	SImy5lUMYHc0MTCTowWx9c8bE1EmC+aNiHBgX+S+7lXp2ybN9Qa69DX3JSVFsm4F1yUcJQ
	ixMibboRcpkEDS54wmmmedIRFyTOav/zp5jkpLcja2CwQuXa5ei+R0+5R3aEDgECsEcWDK
	2DCsa2pYlRCmHgInlyDzHn4xmVPHyvQpiA6rhftca1ARizir+f/dzahEulGYSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732631106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kCD1ZHjwz01Rbei/j//jE5hm6Kci+8lyaIpiJFEDpE=;
	b=MmIZHcEtuQfSCU+d7Yf2VYeL+oaU3bFWsmLu45i+6915d0vKvMTG3uc2u1kSuewEOp7ydk
	dQXWcXPBd3k3WoAQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/CPU/AMD: Terminate the erratum_1386_microcode array
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,  <stable@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241126134722.480975-1-bigeasy@linutronix.de>
References: <20241126134722.480975-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173263110574.412.1382588433469886673.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ff6cdc407f4179748f4673c39b0921503199a0ad
Gitweb:        https://git.kernel.org/tip/ff6cdc407f4179748f4673c39b0921503199a0ad
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 26 Nov 2024 14:47:22 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 26 Nov 2024 15:12:00 +01:00

x86/CPU/AMD: Terminate the erratum_1386_microcode array

The erratum_1386_microcode array requires an empty entry at the end.
Otherwise x86_match_cpu_with_stepping() will continue iterate the array after
it ended.

Add an empty entry to erratum_1386_microcode to its end.

Fixes: 29ba89f189528 ("x86/CPU/AMD: Improve the erratum 1386 workaround")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20241126134722.480975-1-bigeasy@linutronix.de
---
 arch/x86/kernel/cpu/amd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 823f44f..d8408aa 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -798,6 +798,7 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
 static const struct x86_cpu_desc erratum_1386_microcode[] = {
 	AMD_CPU_DESC(0x17,  0x1, 0x2, 0x0800126e),
 	AMD_CPU_DESC(0x17, 0x31, 0x0, 0x08301052),
+	{},
 };
 
 static void fix_erratum_1386(struct cpuinfo_x86 *c)

