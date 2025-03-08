Return-Path: <linux-tip-commits+bounces-4093-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19403A57DBB
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 20:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4594216D2DF
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 19:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA501A7AF7;
	Sat,  8 Mar 2025 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZyOD8aDR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l2bClFKX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BF8148857;
	Sat,  8 Mar 2025 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741461707; cv=none; b=tc6Z2AdE8hoA3I5l0Lje1sFNjgxWsCn5IpaECPPcxcrRlKnT9HuXl/5sEMiwGmSZttWw9r39pe8mtCByu32l8WHGavzAk/wQsUw7MNRJzuCmF8wNvhZ92moKRrrCP5Mo53v6Ht3cWp1N32ThR9mOXRRRpFm/bAo4ra7A0Y5jfh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741461707; c=relaxed/simple;
	bh=RATPhOfpra1/I+BxdMC+oE7skHS5uIAnknN2HIJQnMc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VS0JcvIdYCQ4/Wuim2CtQ9SlNTWZLSp+aHg4Ax5J+SAjZTwHgCiq2Hnx/zZnHBfuZdHdTtXYsAWd7TZKttzYUBypulSCDubDIQ+ZoT7Rdk5Y8CtT/lvYoq5WyprlQOsx8+FP07HkzxoH/1w5N09cwzmjNcgXw7cGx1pOb4vm79Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZyOD8aDR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l2bClFKX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 19:21:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741461703;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OO29idI/yKCRQXHBjKq9k9/QC7tAMjU2iKwSNpMRCu8=;
	b=ZyOD8aDRsJKjqFu6mvStfUABBCK2q5MOMjLOtsDfp4rKb/dt2bb+irokKXVOtQD8KvDb/R
	ts2e/87Ydnf6+tCDZFbJCDWpY3vb6DLmp20y8oC4rquo1vkadPjyxCxGREzo2qvndrgKUw
	FgbqnRuCv3t+yYYUfTJYFbLjzt9KhaMa81zm6qOhZMQ9vKuvdr37WPmIp/jggSsE1DQYML
	46WCosmHxxVSQKJTTmi5da6eA5e/qcj0A5U4abD/7kyvnq3EW+uKaVAZ+9S8B1cwRm+74d
	lYzIpxrc+fDe9CWFIhBRdUxuhnOCalXysEkCsNRTb9wk1ACdDzLgwqI0GaFi5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741461703;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OO29idI/yKCRQXHBjKq9k9/QC7tAMjU2iKwSNpMRCu8=;
	b=l2bClFKXnb//C8oBog2vdWHtZ4eDrd330x1alzl/Fj7/cVTWN8cSubj2esBRytjr0C6Wjn
	geYpGzYBZ5eD6MDQ==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/microcode/AMD: Add some forgotten models to the
 SHA check
Cc: toralf.foerster@gmx.de, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250307220256.11816-1-bp@kernel.org>
References: <20250307220256.11816-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174146170187.14745.11298103616852645546.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     058a6bec37c6c3b826158f6d26b75de43816a880
Gitweb:        https://git.kernel.org/tip/058a6bec37c6c3b826158f6d26b75de4381=
6a880
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 07 Mar 2025 23:02:56 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 08 Mar 2025 20:09:37 +01:00

x86/microcode/AMD: Add some forgotten models to the SHA check

Add some more forgotten models to the SHA check.

Fixes: 50cef76d5cb0 ("x86/microcode/AMD: Load only SHA256-checksummed patches=
")
Reported-by: Toralf F=C3=B6rster <toralf.foerster@gmx.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Toralf F=C3=B6rster <toralf.foerster@gmx.de>
Link: https://lore.kernel.org/r/20250307220256.11816-1-bp@kernel.org
---
 arch/x86/kernel/cpu/microcode/amd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microc=
ode/amd.c
index 95ac1c6..c69b1bc 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -175,23 +175,29 @@ static bool need_sha_check(u32 cur_rev)
 {
 	switch (cur_rev >> 8) {
 	case 0x80012: return cur_rev <=3D 0x800126f; break;
+	case 0x80082: return cur_rev <=3D 0x800820f; break;
 	case 0x83010: return cur_rev <=3D 0x830107c; break;
 	case 0x86001: return cur_rev <=3D 0x860010e; break;
 	case 0x86081: return cur_rev <=3D 0x8608108; break;
 	case 0x87010: return cur_rev <=3D 0x8701034; break;
 	case 0x8a000: return cur_rev <=3D 0x8a0000a; break;
+	case 0xa0010: return cur_rev <=3D 0xa00107a; break;
 	case 0xa0011: return cur_rev <=3D 0xa0011da; break;
 	case 0xa0012: return cur_rev <=3D 0xa001243; break;
+	case 0xa0082: return cur_rev <=3D 0xa00820e; break;
 	case 0xa1011: return cur_rev <=3D 0xa101153; break;
 	case 0xa1012: return cur_rev <=3D 0xa10124e; break;
 	case 0xa1081: return cur_rev <=3D 0xa108109; break;
 	case 0xa2010: return cur_rev <=3D 0xa20102f; break;
 	case 0xa2012: return cur_rev <=3D 0xa201212; break;
+	case 0xa4041: return cur_rev <=3D 0xa404109; break;
+	case 0xa5000: return cur_rev <=3D 0xa500013; break;
 	case 0xa6012: return cur_rev <=3D 0xa60120a; break;
 	case 0xa7041: return cur_rev <=3D 0xa704109; break;
 	case 0xa7052: return cur_rev <=3D 0xa705208; break;
 	case 0xa7080: return cur_rev <=3D 0xa708009; break;
 	case 0xa70c0: return cur_rev <=3D 0xa70C009; break;
+	case 0xaa001: return cur_rev <=3D 0xaa00116; break;
 	case 0xaa002: return cur_rev <=3D 0xaa00218; break;
 	default: break;
 	}

