Return-Path: <linux-tip-commits+bounces-6390-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 483B3B37EBC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 11:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793AC1BA0A91
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 09:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D2D30BB88;
	Wed, 27 Aug 2025 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CtKt5Wix";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nyEMOc+w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343D232C30F;
	Wed, 27 Aug 2025 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286623; cv=none; b=nkhexHVqbGcw9rOfgalJchDexyX9uVvsLdTzvfduPRWoNayAXINGpN42hcK2kVW570Wg/faB8hGw5WVijURHJtjQHHZOQynlObGRf86keZl49oyMNxgUUANA24ctrLzrsVvMP1AjDxozKWsAB+bV/fEatqDN5Vg1zlcHTz0z4IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286623; c=relaxed/simple;
	bh=af9wBVNiT+vTt3mdCy5BmdX+mx3ECi96HTztlfWKrlk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=a8T56KFX1WCmx4toJzTwoosWdAFPTdP4o0UBjXD2bH1FWewNzXlzbyUATlF85VokwuEs3AWizmfYZxQsVYrkUy2AlErv0bKPb85MIpoBnOvaN4l/VjvdbLZXVlAuIXszyqd6VEeNHAF2JI1x+QESZ4sZ/DTaSrFuFnZATm4MbkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CtKt5Wix; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nyEMOc+w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 Aug 2025 09:23:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756286619;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=HsnapUtUIhE8VfoS7U/LyM1dPlMdcpJ0go6jJo/yzIo=;
	b=CtKt5WixCE/9aderZWL527eJ/EkR6SypqwVhzL01GbNf5kmWwOFYUK88kfsSHEqnSzSkQN
	yinL6nMGBZJoXzSCcDI5uY3HAXIhDF+0sDF8tudpNdJFl3pYA84Zg7d6nI5zTAe/i5brra
	Q7JGWr+w7Y81HpzbSjbIT+qNlD6HW0WaWidMKFNrs/hkgr+EGvY7BEm+uQHSR6ZVY5obvE
	N+wbbKIVEoUnWaU+S81xtqCy+j5IE3yDh0pB+na9MxFAqwVBJ9slqg/KnNjYKd8DyFGAui
	lBxOixpmrEDI6auTxC7NswJrj/68ZAHDsbZkh+NfEbnBNCcUZ2CZ8RU33rXlOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756286619;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=HsnapUtUIhE8VfoS7U/LyM1dPlMdcpJ0go6jJo/yzIo=;
	b=nyEMOc+wCn78Lrtl7MY2Vz24GzIJZCst8hjJWbLdxOuIMtAVtrtZGaqomUzuGM4iomU3Ev
	Yd5UjurLz6AzTMAA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/microcode/AMD: Handle the case of no BIOS microcode
Cc: vit.vavra.kh@gmail.com, "Borislav Petkov (AMD)" <bp@alien8.de>,
  <stable@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175628661509.1920.11512044580147254115.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     fcf8239ad6a5de54fa7ce18e464c6b5951b982cb
Gitweb:        https://git.kernel.org/tip/fcf8239ad6a5de54fa7ce18e464c6b5951b=
982cb
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 20 Aug 2025 11:58:57 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 27 Aug 2025 10:24:10 +02:00

x86/microcode/AMD: Handle the case of no BIOS microcode

Machines can be shipped without any microcode in the BIOS. Which means,
the microcode patch revision is 0.

Handle that gracefully.

Fixes: 94838d230a6c ("x86/microcode/AMD: Use the family,model,stepping encode=
d in the patch ID")
Reported-by: V=C3=ADtek V=C3=A1vra <vit.vavra.kh@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
---
 arch/x86/kernel/cpu/microcode/amd.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microc=
ode/amd.c
index 097e393..514f633 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -171,8 +171,28 @@ static int cmp_id(const void *key, const void *elem)
 		return 1;
 }
=20
+static u32 cpuid_to_ucode_rev(unsigned int val)
+{
+	union zen_patch_rev p =3D {};
+	union cpuid_1_eax c;
+
+	c.full =3D val;
+
+	p.stepping  =3D c.stepping;
+	p.model     =3D c.model;
+	p.ext_model =3D c.ext_model;
+	p.ext_fam   =3D c.ext_fam;
+
+	return p.ucode_rev;
+}
+
 static bool need_sha_check(u32 cur_rev)
 {
+	if (!cur_rev) {
+		cur_rev =3D cpuid_to_ucode_rev(bsp_cpuid_1_eax);
+		pr_info_once("No current revision, generating the lowest one: 0x%x\n", cur=
_rev);
+	}
+
 	switch (cur_rev >> 8) {
 	case 0x80012: return cur_rev <=3D 0x800126f; break;
 	case 0x80082: return cur_rev <=3D 0x800820f; break;
@@ -749,8 +769,6 @@ static struct ucode_patch *cache_find_patch(struct ucode_=
cpu_info *uci, u16 equi
 	n.equiv_cpu =3D equiv_cpu;
 	n.patch_id  =3D uci->cpu_sig.rev;
=20
-	WARN_ON_ONCE(!n.patch_id);
-
 	list_for_each_entry(p, &microcode_cache, plist)
 		if (patch_cpus_equivalent(p, &n, false))
 			return p;

