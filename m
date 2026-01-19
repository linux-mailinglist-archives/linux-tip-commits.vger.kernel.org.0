Return-Path: <linux-tip-commits+bounces-8073-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E94DFD3AA86
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Jan 2026 14:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCE6C300FA06
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Jan 2026 13:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925062D6409;
	Mon, 19 Jan 2026 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z8tiaFce";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kCovT2xj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333B71E633C;
	Mon, 19 Jan 2026 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768830006; cv=none; b=J1DpExjLvvhI0xn19tRASE2JZ8/tFYKvGGhPK8oZdLtM16Ge/XMTNTBUye6rRUViwFHGbnUKcq3mo7aKu1hpw7gAxTVZ9MR5z0zHQGQI4Qyq3TkSRJdPh9/6COEcAe3xyTCypVDDHDhFTFpYC1HF4p+7n43yHXocyMPaw/eGM7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768830006; c=relaxed/simple;
	bh=Lfio0nDr9hrKxkJp06rnVC2oMqSpYzAzhO1Jl35TM5Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Dt+7mkP6QppGZm3rLGF3+VAWDu7FZUCdfo8qduJ3+UcYxBtCL6MLes69WQPiv+zc4XmORAbX087n0Yklx7QLyCHfRbasxB8TmKzuPMLB3/zEp2I4/jumv1cHXyOK4Q+W3Se05aCeaX94qmK01GcehOUPjrt46SSzVmCJHDxmSP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z8tiaFce; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kCovT2xj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Jan 2026 13:40:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768830003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+HUOM8x1ZqqtpVXA4a6nZc4ZDGU4PAb+AQDpNtUSu8=;
	b=z8tiaFceYunoDdg6hHnX97isUikWcoNv9Q/HwOwhZhTmfAvCB2UJ7l/UqV11+zpLkGBtMJ
	RXQ55rDtCaSp99as0o/4Btuh07K0d/ks8wadUXTeA03VBhw97oHPheaUL5GLW5NeCm3H0C
	N/WigR5Ds/Dq45qaaGqmmgK8MDers6E82cJlZSgvsvdFL/ktIyvgSlLeA+a2X58fpN95W3
	LeVqpwERUPpI0+sJtrprkR7tWHbg8jJ9IulYdEVPRzdH+RghcIZGJeiWD4CmHmBBhoWmr2
	45sDXAfiIKF1AEqssiaaQnJZD4fOACGTFUN9ow8hPfaEqkBhvspUysCHpNm6Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768830003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+HUOM8x1ZqqtpVXA4a6nZc4ZDGU4PAb+AQDpNtUSu8=;
	b=kCovT2xjyetvuyJTLp4Tz2e9zux9tnra5iCOCLF6yZEeakLawgb5iy2uDaPxTzTgZZ+knq
	ayCGjUbqh400vyCw==
From: "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] MAINTAINERS: Adjust vdso file entry in INTEL SGX
Cc: Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260119093835.114554-1-lukas.bulwahn@redhat.com>
References: <20260119093835.114554-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176883000151.510.15925000772646308622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     436ee609df7da5671ae5a717d1df867313868baf
Gitweb:        https://git.kernel.org/tip/436ee609df7da5671ae5a717d1df8673138=
68baf
Author:        Lukas Bulwahn <lukas.bulwahn@redhat.com>
AuthorDate:    Mon, 19 Jan 2026 10:38:35 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 19 Jan 2026 14:33:14 +01:00

MAINTAINERS: Adjust vdso file entry in INTEL SGX

Commit

  693c819fedcd ("x86/entry/vdso: Refactor the vdso build")

moves the vdso sources into common, vdso32, and vdso64 subdirectories, but
misses to adjust the file entry in the INTEL SGX section of the MAINTAINERS
file.

Adjust the file entry in accordance with the file movement of the commit
above.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20260119093835.114554-1-lukas.bulwahn@redhat.c=
om
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d044a5..7bfc0b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13008,7 +13008,7 @@ S:	Supported
 Q:	https://patchwork.kernel.org/project/intel-sgx/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
 F:	Documentation/arch/x86/sgx.rst
-F:	arch/x86/entry/vdso/vsgx.S
+F:	arch/x86/entry/vdso/vdso64/vsgx.S
 F:	arch/x86/include/asm/sgx.h
 F:	arch/x86/include/uapi/asm/sgx.h
 F:	arch/x86/kernel/cpu/sgx/*

