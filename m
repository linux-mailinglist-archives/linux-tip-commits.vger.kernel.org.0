Return-Path: <linux-tip-commits+bounces-4240-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F22ECA646D0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F054188F6A1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 09:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A35130A7D;
	Mon, 17 Mar 2025 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KM6d9FNW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nes5bOcI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88651B808;
	Mon, 17 Mar 2025 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203035; cv=none; b=Fh/bISY7dRevY9KyKNx3JB0GfRS9VJx1XZ6pP4SS4FXGLop0hfB7jowtuLN08ZFdaJ/yIPpvyyuYy0oHzxsz1eyNXHbpyPSVyFH4bPbQdrF4VCC7MfSPwA53oQI4u2EPy1LKuzxatFqwSLrr6qeJZkKGfh/ZiXZu4vKlqXD000E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203035; c=relaxed/simple;
	bh=SFdl1bbgC9NgF4BSAfhiFNIhZy+CwKcdMwOLdLeey08=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=D35qx86m7RTCjaL6Jt4g0SA94fpQWjzJzjO+7G1MkCDTE9qB2/mIzcUIh0Mx9MJTI6V4eLz9IHlSLnTjkMVP4v7hAzriDYk1qa8JmDF1lWwy70qhyzqlhqurMM9DqiiZRJfk2TW+xPrO3MuCbaxPiDGfjCEimVS9dgV+Y2lBS3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KM6d9FNW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nes5bOcI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 09:17:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742203032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XorjkF2lYdZsdwfxsZdrnUmQrger0j3X+tR7Sab31Uc=;
	b=KM6d9FNW9gCOQuui5foRGGoyV8b4MOPRktcFMsCyiI0xsBtyxX70eeXWNkNgvbm2wkT9xG
	kkp3braAvpfewzQKgXdQbFFGU2BOBpm40C3cQ98mEemTDXSumjX633IDKbiS2hdwsbTqzc
	zRAtbS1J4W+Ydh6Tk+O3PGty32jmSi7Vx7eRurzsimqD+cfCvyHYaN7vgacPhf+Qotzmvi
	GFWntTHbWJAkRKpC/Gn/I2xtDnLKTQDhs+tW4Zvvz2hONxOc3U/vQaM6KHlBOcfs0M6WP3
	6ef2ZQz4fRdSD0YKAKiUf7oP+1GKNSXuYz/pA5d5ErXujrYVsP0HieVeTLcnMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742203032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XorjkF2lYdZsdwfxsZdrnUmQrger0j3X+tR7Sab31Uc=;
	b=Nes5bOcIBvecVX59krtzzDAavT3Ga7Add4z3EkRUsrXBbHmVj68ffZ1jmE5b9WuOehSNTo
	FA6MdpDLYbNpVOAA==
From: "tip-bot2 for Peng Hao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Simplify the code by removing unnecessary
 'else' statement
Cc: Peng Hao <flyingpeng@tencent.com>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220303130.14745.10599780842449444153.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     f0373cc0907ca7918266a507d6b3b5d75ee839ba
Gitweb:        https://git.kernel.org/tip/f0373cc0907ca7918266a507d6b3b5d75ee839ba
Author:        Peng Hao <flyingpeng@tencent.com>
AuthorDate:    Fri, 14 Mar 2025 20:19:53 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 17 Mar 2025 09:02:45 +01:00

x86/sev: Simplify the code by removing unnecessary 'else' statement

No need for an 'else' statement after a 'return'.

[ mingo: Clarified the changelog ]

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/coco/sev/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 82492ef..4e8b800 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1482,8 +1482,7 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	case MSR_AMD64_GUEST_TSC_FREQ:
 		if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
 			return __vc_handle_secure_tsc_msrs(regs, write);
-		else
-			break;
+		break;
 	default:
 		break;
 	}

