Return-Path: <linux-tip-commits+bounces-7673-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EE0CBB83B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C14E9303038C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFDD2D2483;
	Sun, 14 Dec 2025 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pKc04/7l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="60eS7iBx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46A525783C;
	Sun, 14 Dec 2025 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701453; cv=none; b=HXFlhtvb1Jkzj8AkfmzmsT1GLBnM8y7nIfPT+2jTQW4Bj9yQ6DZKw6q08hYENxuaiaEVlfNvulBCQnLlArHz1g/hQpZDxqSEtBjBxdRFY1eNj/Ska7Ks0L1w1Um8H3ejYFxDjlrmH6a+Rw3v8lRccZEyDlZV08egn9RVDNdX1zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701453; c=relaxed/simple;
	bh=2Kgvh4Tkb4+agisgFeXkvo4WrWS8rkDVigLgXSph22w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Lh7Jvjfs8/8FnCthlQ0cU0jHg8HY/0V/ffCyyQf09euPuSszIpSFqE3/TqQAB56j/WETvMK0hKJJRXsfDxt87pQ4WA2CMTzeehG+kPbb3NtDE6azGJbLbNd1i8gnvpp4CvOxNzxIfPULKgEZ7UB3R3J6iABEa2asXsvgC0UQWpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pKc04/7l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=60eS7iBx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701448;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYOBwZAyol/THl9i+HZUPnmu4kGBdV1IIF71pVK5ei0=;
	b=pKc04/7lUHJQ47d2CdgTQjqgScTPD7Fw+H0l3Mncj8ILnG04HATDffpuqpfHn8oZyS/6UP
	BvFzGR42ItTOpiGQ1NzL8zNkJHgLEyOPcqJkhMb+EBTpr60u8erE0wvKMr0SROCMhTTOSp
	tI1mcnBKMhxTqVyiwTUlAKJ+KjmMVro+30KazTYBlW+c3eKw3RLX/Ald8+eY59E1g2TXeX
	cACs3N3dYYWdxtiCtinFE2TQEWoZEaWyeP3RiBchZilxf36z2ltFm1VmyQk5twuZ8wVdys
	fAOqOPbXkpzGkm/w6ObYSqhGyQ+VgBPkq3+eN8+2r0UCMs2WqRmmC+TkI7EXeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701448;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYOBwZAyol/THl9i+HZUPnmu4kGBdV1IIF71pVK5ei0=;
	b=60eS7iBxrAegIg1szI2pklehkMT/h2vQkbRUVMe7RftjxgHUptZjnfUSUO4gph7tDjIKR2
	2CVh0PCwOwvgMHDw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/e820: Change e820_search_gap() to search for
 the highest-address PCI gap
Cc: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Shevchenko <andy@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-22-mingo@kernel.org>
References: <20250515120549.2820541-22-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570144720.498.1814372493153149207.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     f40f3f32b34562672364f02f1b7f7929b8467768
Gitweb:        https://git.kernel.org/tip/f40f3f32b34562672364f02f1b7f7929b84=
67768
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:37 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:40 +01:00

x86/boot/e820: Change e820_search_gap() to search for the highest-address PCI=
 gap

Right now the main x86 function that determines the position and size
of the 'PCI gap', e820_search_gap(), has this curious property:

        while (--idx >=3D 0) {
	...
			if (gap >=3D *gap_size) {

I.e. it will iterate the E820 table backwards, from its end to the beginning,
and will search for larger and larger gaps in the memory map below 4GB,
until it finishes with the table.

This logic will, should there be two gaps with the same size, pick the
one with the lower physical address - which is contrary to usual
practice that the PCI gap is just below 4GB.

Furthermore, the commit that introduced this weird logic 16 years ago:

  3381959da5a0 ("x86: cleanup e820_setup_gap(), add e820_search_gap(), v2")

  -                       if (gap > gapsize) {
  +                       if (gap >=3D *gapsize) {

didn't even declare this change, the title says it's a cleanup,
and the changelog declares it as a preparatory refactoring
for a later bugfix:

  809d9a8f93bd ("x86/PCI: ACPI based PCI gap calculation")

which bugfix was reverted only 1 day later without much of an
explanation, and was never reintroduced:

  58b6e5538460 ("Revert "x86/PCI: ACPI based PCI gap calculation"")

So based on the Git archeology and by the plain reading of the
code I declare this '>=3D' change an unintended bug and side effect.

Change it to '>' again.

It should not make much of a difference in practice, as the
likelihood of having *two* largest gaps with exactly the same
size are very low outside of weird user-provided memory maps.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H . Peter Anvin <hpa@zytor.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://patch.msgid.link/20250515120549.2820541-22-mingo@kernel.org
---
 arch/x86/kernel/e820.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index b8edc5e..3fba540 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -655,7 +655,7 @@ static int __init e820_search_gap(unsigned long *gap_star=
t, unsigned long *gap_s
 		if (last > end) {
 			unsigned long gap =3D last - end;
=20
-			if (gap >=3D *gap_size) {
+			if (gap > *gap_size) {
 				*gap_size =3D gap;
 				*gap_start =3D end;
 				found =3D 1;

