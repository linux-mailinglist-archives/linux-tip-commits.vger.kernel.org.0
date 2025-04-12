Return-Path: <linux-tip-commits+bounces-4913-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82168A86F8D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Apr 2025 22:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD483A9DF4
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Apr 2025 20:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5649021B1B9;
	Sat, 12 Apr 2025 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V/1F9dqJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R2FnrFfX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C31A18A6B6;
	Sat, 12 Apr 2025 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744489765; cv=none; b=pI08IGX8u+k4Ul3x/QlWSGFMsSiVy2K13QCaOjAOJNe3EomUT3pzyzzkOHxsjhwQjqejvjShkB8+BiP/Fz9viwtcECpQnGgpQnuhG1jvJ8VTNue6pt3GjAjPca6PP122c6r89BifgPD64ocpuGmf1yCoSz5Yo47cjU3d5F4oW90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744489765; c=relaxed/simple;
	bh=oSRzl6xCadlLPSgwC5pzXugd5LI4wbD6FntbcOzbxUE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dWYYicZtFLu/Ee8soa1+/wI20OfcfrJepCKT0Sbs21RTEz+7RX6ttB36e2hjrxEymP6R3/3Mq08pZMDLJjVVWT/EJTCxcbZ+WG3lFkb2P5oPx+HP4AxApqHMapYKtuEoG+6jNCGt3+fo1APbiZhwCnvFXu1eY/+sCXKM+JqGVMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V/1F9dqJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R2FnrFfX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Apr 2025 20:29:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744489761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0cwLgig6SdDJidlViCscg67DNP/DjlcAWi0eEudK/c=;
	b=V/1F9dqJAnl0HW6arseno/koDzuzsK7NRca1wsbJhrAMCAM4jXqJSZdxKrQKlWiwIJHAXY
	NP5tse/rcYek7MTlpX257RigdU0m5oShG+wfD+dpQNd3b4DDF65XxFF0g60Bt4WzQRT4SR
	TzlDgB0IeSemBSzUKs1mIpLwMgCU6RpxhkUsIVRPV+NssroqpSxoH9ulhpfKLgr2thFqvT
	e9mAcs1yFDkMjiLv15esFc+/ElO9pJK8rkoAwW4O57o3+GUoH6ofe89k2QLMuYSxGWkquF
	c1dnYQ79846Op5ZnVL4oCNmHGisWxBkRRWfMTuqcinuJucMbBiX+3jXs9koC3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744489761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0cwLgig6SdDJidlViCscg67DNP/DjlcAWi0eEudK/c=;
	b=R2FnrFfX25IGUdsG5+FofXV1SUQGSbYuDCUz/HAlwXIu+Ai2WgBatCZ9DGFTUwi4GUEG5Y
	KgLTFZeIlEPDFmAg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/microcode/AMD: Extend the SHA check to Zen5,
 block loading of any unreleased standalone Zen5 microcode patches
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
  <stable@kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Nikolay Borisov <nik.borisov@suse.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250410114222.32523-1-bp@kernel.org>
References: <20250410114222.32523-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174448975612.31282.16734992697448931716.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     805b743fc163f1abef7ce1bea8eca8dfab5b685b
Gitweb:        https://git.kernel.org/tip/805b743fc163f1abef7ce1bea8eca8dfab5b685b
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 10 Apr 2025 13:42:22 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 12 Apr 2025 21:09:42 +02:00

x86/microcode/AMD: Extend the SHA check to Zen5, block loading of any unreleased standalone Zen5 microcode patches

All Zen5 machines out there should get BIOS updates which update to the
correct microcode patches addressing the microcode signature issue.
However, silly people carve out random microcode blobs from BIOS
packages and think are doing other people a service this way...

Block loading of any unreleased standalone Zen5 microcode patches.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Cc: Nikolay Borisov <nik.borisov@suse.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20250410114222.32523-1-bp@kernel.org
---
 arch/x86/kernel/cpu/microcode/amd.c |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index b61028c..4a10d35 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -199,6 +199,12 @@ static bool need_sha_check(u32 cur_rev)
 	case 0xa70c0: return cur_rev <= 0xa70C009; break;
 	case 0xaa001: return cur_rev <= 0xaa00116; break;
 	case 0xaa002: return cur_rev <= 0xaa00218; break;
+	case 0xb0021: return cur_rev <= 0xb002146; break;
+	case 0xb1010: return cur_rev <= 0xb101046; break;
+	case 0xb2040: return cur_rev <= 0xb204031; break;
+	case 0xb4040: return cur_rev <= 0xb404031; break;
+	case 0xb6000: return cur_rev <= 0xb600031; break;
+	case 0xb7000: return cur_rev <= 0xb700031; break;
 	default: break;
 	}
 
@@ -214,8 +220,7 @@ static bool verify_sha256_digest(u32 patch_id, u32 cur_rev, const u8 *data, unsi
 	struct sha256_state s;
 	int i;
 
-	if (x86_family(bsp_cpuid_1_eax) < 0x17 ||
-	    x86_family(bsp_cpuid_1_eax) > 0x19)
+	if (x86_family(bsp_cpuid_1_eax) < 0x17)
 		return true;
 
 	if (!need_sha_check(cur_rev))

