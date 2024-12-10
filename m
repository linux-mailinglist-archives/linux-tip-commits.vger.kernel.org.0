Return-Path: <linux-tip-commits+bounces-3051-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC489EBB28
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Dec 2024 21:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1C4283904
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Dec 2024 20:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C224322B5A0;
	Tue, 10 Dec 2024 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YSWBX2LS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XjDrULVy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B0A23ED69;
	Tue, 10 Dec 2024 20:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733863982; cv=none; b=mpQH8ph74QOd17whRZYVrgi40n13MAneRmxHNECJyBfamfuTITtbIS0Lv5dAmLKxAIkE8BzJR8OZ5fmvjWdVQds7rZqPyKue1b2O1c5N5jWU5qJ7BNzbmdLrlrnR3wH0Jn+hxzK/+jat87b7sjbkCbNWBXPdP9KzMghU8+mbJeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733863982; c=relaxed/simple;
	bh=s0TRnZtFR890JeVCNpOmBcdy1D83EKsIlytGEKLxifE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MWK4pKHOcdNdoR8PJz5p5ufAWlCI/+Dp2F63qUFGHoQoSjWH0xc91acP5dRM/JSHxSS6s3DuwQ722hK66xlrpCtAr2NwF7Q6WFXpfskFLGPdzdVupOpgvje/SCnvsSy96/NVZc3n0lVH5dJkJGvYmG+tiYXE/4Yd+e14ODRuN+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YSWBX2LS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XjDrULVy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Dec 2024 20:52:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733863978;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVORK7EsuNGvc3TnrTmkdtEnNvYUCHOONCh3cTVipLY=;
	b=YSWBX2LSO8UhSe9zCmea9lnhZ9GONfnXyT5G3pYv7SQXqYzMNIRkV5h6Cb3hqunkaoehI3
	mCw3eKSagiDqw6qYCq7DUtoaCtt8MKQaeMD1Jr8nZe11ByxvkhOpWCGGGD3qQ4rDps4IBk
	1sqSy5pJARm/Qhha3ugnzdiYn6VZY/2C9W/DtNeo/Ims0yoHdmsDYrLH2trv3vSIgaOeZH
	cIVYsAtPpbi6EGilOnWW9c+jMflny/vcVJcwlJWO39V7lSWgo1ZVPZsU7CG2EFBc18Yke7
	RzhJpxKqN44W6B4WNQQMNU0I44wlq3aNXCWpYF9fDTY3GBobU3a2umDPXs7Qhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733863978;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVORK7EsuNGvc3TnrTmkdtEnNvYUCHOONCh3cTVipLY=;
	b=XjDrULVySMdwCDPCv5VtuQugxl5OslXK0RagMYeWAKwThUPj7bnFHqhBBBoojAF+jIy/Sy
	SJ0dnRXzOncvQeCA==
From: "tip-bot2 for Raag Jadav" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/cpu: Fix typo in x86_match_cpu()'s doc
Cc: Raag Jadav <raag.jadav@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241030065804.407793-1-raag.jadav@intel.com>
References: <20241030065804.407793-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173386397796.412.4053309518488964075.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     3560a023a9b9965803e8a967ee88343879b5dc1b
Gitweb:        https://git.kernel.org/tip/3560a023a9b9965803e8a967ee88343879b5dc1b
Author:        Raag Jadav <raag.jadav@intel.com>
AuthorDate:    Wed, 30 Oct 2024 12:28:04 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 10 Dec 2024 21:40:02 +01:00

x86/cpu: Fix typo in x86_match_cpu()'s doc

Fix typo in x86_match_cpu()'s description.

  [ bp: Massage commit message. ]

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241030065804.407793-1-raag.jadav@intel.com
---
 arch/x86/kernel/cpu/match.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index 8e7de73..82e5d29 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -6,7 +6,7 @@
 #include <linux/slab.h>
 
 /**
- * x86_match_cpu - match current CPU again an array of x86_cpu_ids
+ * x86_match_cpu - match current CPU against an array of x86_cpu_ids
  * @match: Pointer to array of x86_cpu_ids. Last entry terminated with
  *         {}.
  *

