Return-Path: <linux-tip-commits+bounces-7034-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4E2C192AA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 09:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED3918878DD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 08:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCDA313E1B;
	Wed, 29 Oct 2025 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jpPvPu8m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZLDtXFHp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E4A313531;
	Wed, 29 Oct 2025 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727344; cv=none; b=ugPaJoujSqwZ67aWeVAfOU4hmAEbwLgjhNduKZhDJzh6ecHf+iCkPpWq32583BjW0rKOITNbjGpbIgG3/OxGrqV+1laoMeorjcZswreiLC2XxlIG++dcQkD6LfqkYUtW0LDNpHziiGpZoe76sqFZI9IHMS0yIiErOAgSHV6cSII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727344; c=relaxed/simple;
	bh=l4KMCt28QPA9jOqKdHoSeAYet8hrqrOSAnFMkUBD8I4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gWzhgL2LZ/kFI0N0thHaro2NEL0TB6KRwpK9c7VmDoJpYaGb9Y362wRNYV5u+a861h5tNqnBIH54yhdpOToLoFmqvW12+moVhRZK7cLoGW50s7F6hDtHb8D2NORPIMIrqKEBl80ms44eVfbUfAT8LrERKvBu6vuVQ43c60GIzNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jpPvPu8m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZLDtXFHp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 08:42:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761727333;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=354zUnwCvZdoVPz4k00+0fZtZARvZnqYK9skA/gWzlg=;
	b=jpPvPu8mtzDbrvg3SK8V/fZdU5EqXbKR+k1j488BK7KT8n3bG6PlHH0DYP1PcCriIsQ8L8
	XQ/vxBz+ukwHBWcrUrXEd6VaYG27HqVIGy5To0DlVEnMEjXjIUlgcVW2egasOd7p83BunI
	ZIcx5RbNMkEFAyT/LeV8H8unslECpLYXGrHOgmwNF5VmmUawbFNJSmK+pKHHHRqwJMq7SV
	e5jLBlL8XFylhytoRhwpfUIoSZV7o6yriKekIADI3Eov97EQl1xOT+5g8oylNGZwMlF63h
	MGPSj7G9Ybl6p4KtWj8znwQALwaIwqUrspMux3X33/wCw2WK5i/NVnZ66vmqnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761727333;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=354zUnwCvZdoVPz4k00+0fZtZARvZnqYK9skA/gWzlg=;
	b=ZLDtXFHp+wLRmnb6ze1tZWJwL7n+OPsuZ1x3cKakd2QnQ9EVl+mzGluyI0tgIKeW0mLM4J
	KsuGBQTWmvE1dmCA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/cpu: Add/fix core comments for {Panther,Nova} Lake
Cc: Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251028172948.6721-1-tony.luck@intel.com>
References: <20251028172948.6721-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176172732774.2601451.733031982058363091.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1e7fb6602e2e63b92430ec54a9edb731a51dfbc7
Gitweb:        https://git.kernel.org/tip/1e7fb6602e2e63b92430ec54a9edb731a51=
dfbc7
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 28 Oct 2025 10:29:48 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 29 Oct 2025 09:39:34 +01:00

x86/cpu: Add/fix core comments for {Panther,Nova} Lake

The E-core in Panther Lake is Darkmont, not Crestmont.

Nova Lake is built from Coyote Cove (P-core) and Arctic Wolf (E-core).

Fixes: 43bb700cff6b ("x86/cpu: Update Intel Family comments")
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://patch.msgid.link/20251028172948.6721-1-tony.luck@intel.com
---
 arch/x86/include/asm/intel-family.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel=
-family.h
index f32a0ec..950bfd0 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -150,12 +150,12 @@
=20
 #define INTEL_LUNARLAKE_M		IFM(6, 0xBD) /* Lion Cove / Skymont */
=20
-#define INTEL_PANTHERLAKE_L		IFM(6, 0xCC) /* Cougar Cove / Crestmont */
+#define INTEL_PANTHERLAKE_L		IFM(6, 0xCC) /* Cougar Cove / Darkmont */
=20
 #define INTEL_WILDCATLAKE_L		IFM(6, 0xD5)
=20
-#define INTEL_NOVALAKE			IFM(18, 0x01)
-#define INTEL_NOVALAKE_L		IFM(18, 0x03)
+#define INTEL_NOVALAKE			IFM(18, 0x01) /* Coyote Cove / Arctic Wolf */
+#define INTEL_NOVALAKE_L		IFM(18, 0x03) /* Coyote Cove / Arctic Wolf */
=20
 /* "Small Core" Processors (Atom/E-Core) */
=20

