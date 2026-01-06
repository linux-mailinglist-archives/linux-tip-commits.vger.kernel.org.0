Return-Path: <linux-tip-commits+bounces-7827-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C939CFA303
	for <lists+linux-tip-commits@lfdr.de>; Tue, 06 Jan 2026 19:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4075531D5228
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Jan 2026 17:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA3434EEFA;
	Tue,  6 Jan 2026 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tf0Km049";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a2itULVO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF34D34EEF4;
	Tue,  6 Jan 2026 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720469; cv=none; b=PVJIzkygsz0SFfPIXtySikmSZfduYn3Oeb7ybu7dw0TaHNcdVeFo2EdwEKNK4uOs+LxrQ2/3vEv3Wg6gi8wbNqXgW1c/crUXSCD3vK/gyZy04QBOrOeJ8ot4oP+uAAVi8AxFywsGtn7L1jgQk/IhgkVFW3JcNtTK4j36NDyayxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720469; c=relaxed/simple;
	bh=V6w8bsbZVPgcbYFHIBVki3C5kNJFRWmW7cYw+kHOWW8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G5cE3kKmN6vrQJ8G3nP7TYBD/MuM5Z3AtaG5JynNyxI1j+YoxPmTq07xJo73fPlTPNuzJDsB/yZXNUbcXJRsaUmOlncMW1ht8WP9wQSkvhy0ApQRri1Braj9sIaCsNjmHnnt+0yNPq33j4olSvV17HWIvzqHdA/VbqW+mg7HE/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tf0Km049; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a2itULVO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 Jan 2026 17:27:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767720466;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SEwAF0kSD5sc+9mBXuz7NSKuHCtAWmO079OKrjVzowA=;
	b=tf0Km049hZ5y5D8fGh+O3J627DPbpOBMMSiWv6+brMxottH6OGL9jB7YkUOEstFOO17wFW
	VYsdAaK5qJlbOoudPR14C9RzQs+Tm5RTvxWcbEXrAu3Z+b1i3U99Yd1t7HJuMoE+puiyTM
	hBW+pqVCtazlBWUclz7cswUAqtH2r53bPZEyaDTPWHE+CD8Dm73mkrLBXGwuDUNa5IebhS
	Uh7ZYnBppuaWu3zgFN3xbYu4hbwpY2A7wdhw67YChZrkngZFOZPC6UIyRlgYdP862fVLIb
	b6BW2LEpaSW/TpwzyCw6ZCSllOQW/F5h75sKBBsVe6ZdKM7MREzypMVXY1EMlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767720466;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SEwAF0kSD5sc+9mBXuz7NSKuHCtAWmO079OKrjVzowA=;
	b=a2itULVOtXkVSmq6djIDV9VBup0mIzPR+HmECAhQINN4vf/RGR/OyNizs36ROLv9A+j4fY
	ujbE0FGN7mYUeSCw==
From: "tip-bot2 for Nikolay Borisov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/tsx: Set default TSX mode to auto
Cc: Nikolay Borisov <nik.borisov@suse.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251112190548.750746-1-nik.borisov@suse.com>
References: <20251112190548.750746-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176772046462.510.7125614145328672643.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     f8c7600d468bdb6e44ed3b3247c6e53f5be5d8de
Gitweb:        https://git.kernel.org/tip/f8c7600d468bdb6e44ed3b3247c6e53f5be=
5d8de
Author:        Nikolay Borisov <nik.borisov@suse.com>
AuthorDate:    Wed, 12 Nov 2025 21:05:48 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 06 Jan 2026 09:23:30 -08:00

x86/tsx: Set default TSX mode to auto

At SUSE we've been releasing our kernels with TSX enabled for the past 6
years and some customers have started to rely on it. Furthermore, the last
known vulnerability concerning TSX was TAA (CVE-2019-11135) and a
significant amount time has passed since then without anyone reporting any
issues. Intel has released numerous processors which do not have the
TAA vulnerability (Cooper/Ice Lake, Sapphire/Emerald/Granite Rappids)
yet TSX remains being disabled by default.

The main aim of this patch is to reduce the divergence between SUSE's
configuration and the upstream by switching the default TSX mode to
auto. I believe this strikes the right balance between keeping it
enabled where appropriate (i.e every machine which doesn't contain the
TAA vulnerability) and disabling it preventively.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251112190548.750746-1-nik.borisov@suse.com
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8052729..f1c98a9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1816,7 +1816,7 @@ config ARCH_PKEY_BITS
 choice
 	prompt "TSX enable mode"
 	depends on CPU_SUP_INTEL
-	default X86_INTEL_TSX_MODE_OFF
+	default X86_INTEL_TSX_MODE_AUTO
 	help
 	  Intel's TSX (Transactional Synchronization Extensions) feature
 	  allows to optimize locking protocols through lock elision which

