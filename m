Return-Path: <linux-tip-commits+bounces-7276-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9F1C3FBCE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 07 Nov 2025 12:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A6C1884A61
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Nov 2025 11:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41C921FF36;
	Fri,  7 Nov 2025 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nXvgEGDo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lk4+2tg3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E002222CB;
	Fri,  7 Nov 2025 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515037; cv=none; b=SrkbxzofI8FNsQW5qsoIT/4Dd6IflmaK47c6rOGKHhibmN39GoBxymjZmLEEZb9iT/XsSF5FGBN5R6LWLKqGYjyHhWRoDxjlqp57q1ALvfbwvMIpd5eUwtz3CZI0iiIO667NIa+xhE7gGKhhyedLrKcQX58IULMxgrqGOwxosHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515037; c=relaxed/simple;
	bh=Iof+12xLwEi28tQXd4VoueI4a7bB7kbPWKUpfW/YvAQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LGn0TQXAmHnKNXsOWfo3H7/rvjsxRAM9DxKH4/Y7K+JlEkzobmM3pYP2n8m/c49qbUmreXmP0jy7BeDMeKF1pbYKRs9nCm6Qx8K9/CLnJdINp/hLHIUXfpJrLPm/Cf8mP3awAyJ/EhfOkFHfoQnSs0wf3XQLFRkE7ge9xaUwCsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nXvgEGDo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lk4+2tg3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 07 Nov 2025 11:30:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762515034;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/uXuiPuq1GWuzvLqPew7saKFbB6At6saQXmSK+nLmI=;
	b=nXvgEGDom5OOL+0nF1lnfsHy/ekPFJuldTv5SVNxCmdREy/GLVt9iiuiur4LVwJzFFciqt
	uG8Ck0UPaPPJ9HyHt42laXNE9QjERhJ5DkEGe6kkiDHFU6wGzv+h6D0nY1cOufDdvBAXOW
	zeFaMvECGKX3rTSX7iacX6ieuhCWsgJWQBR/26DpgnK7sjlBweBk/mwlU00V6wOAAvIFl6
	HOsjf0XnMA/ri1lQoABlFjLti+ZRt6MlNg1q6p0kEZ0m6X4niNOzivxEfzFKmpEvso2OAi
	u3wcDaBkcvXhw7yhYwpt2mVoYITq7YpMFrV1P4WYoHOYb6m3OANs9EpYWNKRWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762515034;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/uXuiPuq1GWuzvLqPew7saKFbB6At6saQXmSK+nLmI=;
	b=lk4+2tg31ARQqS4kl0IoEwx+1T15/KnhqIWTLbazjkEm6EcNuMRAFJUIcjXDT2xK9bIaMS
	4jiCubJYHkd0QdCg==
From: "tip-bot2 for Mario Limonciello (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/microcode/AMD: Add more known models to entry
 sign checking
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,  <stable@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251106182904.4143757-1-superm1@kernel.org>
References: <20251106182904.4143757-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176251502918.2601451.14150403069865878876.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d23550efc6800841b4d1639784afaebdea946ae0
Gitweb:        https://git.kernel.org/tip/d23550efc6800841b4d1639784afaebdea9=
46ae0
Author:        Mario Limonciello (AMD) <superm1@kernel.org>
AuthorDate:    Thu, 06 Nov 2025 12:28:54 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 07 Nov 2025 12:12:21 +01:00

x86/microcode/AMD: Add more known models to entry sign checking

Two Zen5 systems are missing from need_sha_check(). Add them.

Fixes: 50cef76d5cb0 ("x86/microcode/AMD: Load only SHA256-checksummed patches=
")
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://patch.msgid.link/20251106182904.4143757-1-superm1@kernel.org
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microc=
ode/amd.c
index b7c797d..dc82153 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -220,10 +220,12 @@ static bool need_sha_check(u32 cur_rev)
 	case 0xaa001: return cur_rev <=3D 0xaa00116; break;
 	case 0xaa002: return cur_rev <=3D 0xaa00218; break;
 	case 0xb0021: return cur_rev <=3D 0xb002146; break;
+	case 0xb0081: return cur_rev <=3D 0xb008111; break;
 	case 0xb1010: return cur_rev <=3D 0xb101046; break;
 	case 0xb2040: return cur_rev <=3D 0xb204031; break;
 	case 0xb4040: return cur_rev <=3D 0xb404031; break;
 	case 0xb6000: return cur_rev <=3D 0xb600031; break;
+	case 0xb6080: return cur_rev <=3D 0xb608031; break;
 	case 0xb7000: return cur_rev <=3D 0xb700031; break;
 	default: break;
 	}

