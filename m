Return-Path: <linux-tip-commits+bounces-7695-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3652FCBCC15
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 08:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73E0E3005E90
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 07:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A720E30E82B;
	Mon, 15 Dec 2025 07:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eJ4ZRX1O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CpVg2thx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5CA30E851;
	Mon, 15 Dec 2025 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765783479; cv=none; b=aT9gmEFmrHKR31rdBdQhpapLimSt+1p51KGjoGORjiHqd8HeIhpakF/bKUhft9K7XQi03sPFWw6NTpKnI0Q/q30JPoDTxFbEZYhaDa4n1qmsqIWI5UJX/gq14EzlWt+WVhNtEUBAKLKJyrOQhjf1H3mrFDGGLuUUgrIKIQmhdHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765783479; c=relaxed/simple;
	bh=7zuC7DnxhkpZA/sSCWAFuz2HR9DYA9L9P9PHW8HLhVQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T6y8+aUk7r/ig3rq8dL4D3yhcreOGvKLWaJC37LntAjjA0vAjLP9ISoj36y9CuN8kfHn4KcoF725zIU/57bBlj7Z6Dc08CewyV7gEzTF2psJ7hRtP8zglsB0zXr96IPyK267MtYTRrQ/ktsaRlUuyu0gMMMGi2HsCHYqgwh6oHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eJ4ZRX1O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CpVg2thx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 07:18:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765783118;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JhnIMPS7yGXAZhZzPupjSui5jA4EAlKTkzBySwBbLx8=;
	b=eJ4ZRX1OWpBck8AA1XYaE4IcaaCagVdmRE0rQq/20UNBBt6ez61RvUMExacaDvrGmr0y35
	qC05eq9ny8vdgK6BymtSqe5bTw7QpUNmPsJQks7Yy2jrKgYHhRm/5d7mhtLXgPhSC8RZjL
	Ni3iJTPQOmK8gP10VgJeMbTSptdGukXoiyrbozBWsBaG7xGFjvoNa6g3Zjg2Ocig9tAqge
	tSoQNLpnYs2UIk0QtASBTmyo/NUMCLw6E/ha5XEUkI8IHWrZZcGNYZE3pI7A9wCgBnuV9A
	pFWTX/xxwGAzZK1bOt9fSDePgkBgE4wD17dCViqqvTmtWLRJVKrvZ4Nszyl64Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765783118;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JhnIMPS7yGXAZhZzPupjSui5jA4EAlKTkzBySwBbLx8=;
	b=CpVg2thxIlbZCMSty1+3QQBkq9Cc+6sTqsQqycQjZAd6UDYB220EZQ0Zv9DlVC3eyvz33U
	pRf0Uh7qn4bTfNAg==
From: "tip-bot2 for Andrew Cooper" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/amd: Use ZEN_MODEL_STEP_UCODE() for
 erratum_1386_microcode[]
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Ingo Molnar <mingo@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Mario Limonciello <mario.limonciello@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251126113442.877024-1-andrew.cooper3@citrix.com>
References: <20251126113442.877024-1-andrew.cooper3@citrix.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176578311706.498.13474176921916799966.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     a2aabcfc6015b6196f161b6bf4df1519ab09c3e1
Gitweb:        https://git.kernel.org/tip/a2aabcfc6015b6196f161b6bf4df1519ab0=
9c3e1
Author:        Andrew Cooper <andrew.cooper3@citrix.com>
AuthorDate:    Wed, 26 Nov 2025 11:34:42=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:55:47 +01:00

x86/cpu/amd: Use ZEN_MODEL_STEP_UCODE() for erratum_1386_microcode[]

... to simplify the result.

No functional change.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20251126113442.877024-1-andrew.cooper3@citrix.=
com
---
 arch/x86/kernel/cpu/amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 86059f2..c04f53f 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -873,8 +873,8 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
 }
=20
 static const struct x86_cpu_id erratum_1386_microcode[] =3D {
-	X86_MATCH_VFM_STEPS(VFM_MAKE(X86_VENDOR_AMD, 0x17, 0x01), 0x2, 0x2, 0x08001=
26e),
-	X86_MATCH_VFM_STEPS(VFM_MAKE(X86_VENDOR_AMD, 0x17, 0x31), 0x0, 0x0, 0x08301=
052),
+	ZEN_MODEL_STEP_UCODE(0x17, 0x01, 0x2, 0x0800126e),
+	ZEN_MODEL_STEP_UCODE(0x17, 0x31, 0x0, 0x08301052),
 	{}
 };
=20

