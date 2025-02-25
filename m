Return-Path: <linux-tip-commits+bounces-3620-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FB9A44D7C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 21:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6AB117A02E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 20:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DB02135C8;
	Tue, 25 Feb 2025 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KMGKA5Pi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WQW6a5GY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84F313B5B6;
	Tue, 25 Feb 2025 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514780; cv=none; b=erPlk+MVTo+ryCwBBTW+7HrCvAUxWUlTnhJ49yY9XGo2L5Q8UcUvaU2BYHlTl4NAFaiJbfCWCgMct0mVb0hLRsLR/gEFEQw5QY9P7tMKKTD0t29gSMcUvHDx57vynLbKPdmp9MiE0OmBnMrzbdF1yE7JCVtG1JlGQbz0+37DoMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514780; c=relaxed/simple;
	bh=dPXiOUFVaIkEzWVZRXQdZ4XmO3+P2qQhKe3j18E5SFY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cOPsSAaI45dTZaOd4alU3pivEGPx/xQ4S2MZF/q7kADNvY0UvbXvnonOPqyNR2lY80ruFPAbUHJcJstF65ilFSvdjsKDwnd8DWKIjp5Z3jGUuczuMrUmG8EAPZMfv99/1XgGhd54julCMBv7NQxT4Bs3BmURZ9vfjztJ7nQS2b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KMGKA5Pi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WQW6a5GY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Feb 2025 20:19:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740514777;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HFGDOi/a3IZOwVxWMQ7d8cUM7FNhx2Vkri0Rm1SBC58=;
	b=KMGKA5PiissaC+itI5aEkJLEIrZpICcPkLQ1bjOsWmDG/YLh0TQWPapccAjYQa7hmfDL0k
	FEnpULhGWF+TCrPxtQL9mr/D9uwuWQe7RuE5qT8Amf+keKKQu0MmwPOih8pVkkKcIDvfdI
	8A4yjEIHbrI7FD6lP+rhq4oZKCTlMFRTgVSw0lhBFr+JJs49K85il+u+6kumIH9h7lzlCS
	WAktOCnA4v3RRQZsSruTbvjguEZG+eu3IFCEPf0w9AOgZO2v4rZ8bv/4lXwKS8eJwBEMLn
	tzMG2KDdnUQAK29DQeV3PBoSZ+D5LVgSDXMu4p/zcP0sCKxuIFSnZuMp7vP08w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740514777;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HFGDOi/a3IZOwVxWMQ7d8cUM7FNhx2Vkri0Rm1SBC58=;
	b=WQW6a5GYNQvf483zT+YNbNOifDrRqbXvUvJt21Kq2f8BlrOgjzZCVfZMqzaTp+2wkRKRZP
	m+KYEM3qWyknCvCQ==
From: "tip-bot2 for Nir Lichtman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/build: Fix broken copy command in genimage.sh
 when making isoimage
Cc: Nir Lichtman <nir@lichtman.org>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250110120500.GA923218@lichtman.org>
References: <20250110120500.GA923218@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174051477652.10177.16350027311540309473.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     e451630226bd09dc730eedb4e32cab1cc7155ae8
Gitweb:        https://git.kernel.org/tip/e451630226bd09dc730eedb4e32cab1cc7155ae8
Author:        Nir Lichtman <nir@lichtman.org>
AuthorDate:    Fri, 10 Jan 2025 12:05:00 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Feb 2025 21:13:33 +01:00

x86/build: Fix broken copy command in genimage.sh when making isoimage

Problem: Currently when running the "make isoimage" command there is an
error related to wrong parameters passed to the cp command:

  "cp: missing destination file operand after 'arch/x86/boot/isoimage/'"

This is caused because FDINITRDS is an empty array.

Solution: Check if FDINITRDS is empty before executing the "cp" command,
similar to how it is done in the case of hdimage.

Signed-off-by: Nir Lichtman <nir@lichtman.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Link: https://lore.kernel.org/r/20250110120500.GA923218@lichtman.org
---
 arch/x86/boot/genimage.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/genimage.sh b/arch/x86/boot/genimage.sh
index c9299ae..3882ead 100644
--- a/arch/x86/boot/genimage.sh
+++ b/arch/x86/boot/genimage.sh
@@ -22,6 +22,7 @@
 # This script requires:
 #   bash
 #   syslinux
+#   genisoimage
 #   mtools (for fdimage* and hdimage)
 #   edk2/OVMF (for hdimage)
 #
@@ -251,7 +252,9 @@ geniso() {
 	cp "$isolinux" "$ldlinux" "$tmp_dir"
 	cp "$FBZIMAGE" "$tmp_dir"/linux
 	echo default linux "$KCMDLINE" > "$tmp_dir"/isolinux.cfg
-	cp "${FDINITRDS[@]}" "$tmp_dir"/
+	if [ ${#FDINITRDS[@]} -gt 0 ]; then
+		cp "${FDINITRDS[@]}" "$tmp_dir"/
+	fi
 	genisoimage -J -r -appid 'LINUX_BOOT' -input-charset=utf-8 \
 		    -quiet -o "$FIMAGE" -b isolinux.bin \
 		    -c boot.cat -no-emul-boot -boot-load-size 4 \

