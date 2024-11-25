Return-Path: <linux-tip-commits+bounces-2880-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D599D8D94
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Nov 2024 21:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3505216A733
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Nov 2024 20:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A90A18130D;
	Mon, 25 Nov 2024 20:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IQllB0Dv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jB6aellf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB6017BB0F;
	Mon, 25 Nov 2024 20:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732567952; cv=none; b=l1pNGfk2XYd3ZXyFA6P04ujR+q/DYyBP1c9T+/i5gjSamxhTfDJq4GxwgsqbjnjE0bcERXyeddTxYJCEjfrUovVmy80/HfGBJLT89tTlDF4xgdSfVqg/aboxC5RXIzRpbg1FYIxlSkYbsqL9iWCQY8CHl1II1x9PLbYqGk58KOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732567952; c=relaxed/simple;
	bh=T1R1RHMgeTnFU18qwLG7PaG8lGGU3M67046FXtJWul8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MfJPfcJHOgDlpxZ55X11bXxN5epX+9J4Ri768CXhEWQsA3bdJ4f60WvWsAqyxkaZn41wiotH+nsoBq9G1N8+puxtKvFiT8QliR0zvpPKmSq2TMiPFVdQLbBpRTkRWEBZEZuIlCug7p/j1zrQWwsd3FzUKhqz9BNz1tAeKvE+qaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IQllB0Dv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jB6aellf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Nov 2024 20:52:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732567948;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nRx7B+vn/IKqLeN7//vuxMPJaAva2OfmwM07pIKsra0=;
	b=IQllB0DveYC/DrSofUmpx7EEKRi7ZtfYE9Yz8XSzO4l72MRITI4/EYX8URFXITJ5bvCGlc
	Q+E6XoufkRAIQ/cJ3BSy2G4bbnmZIxOpP4TGWK8h/kqwAYcAMKwi68fbDZO+KseZ/x7XgZ
	VQqI8m2n6dzAClo8+s8RJiG3jR08hFpxxqbZ4WpRUGMMVW1x2GVIhtcZUoUNx5wQ5RcEdj
	NaMCF3u7uWv+cSCIOFtjuHitkUB0+iz85pC5TnlVIouQFdTivU9ui7f2xugUx/2+VLDL6v
	eP+is7KCJolVL93xAgb5TJBqAv6vEgYLWfhPFAkhFfgSakjjL3I+l1JHCjobFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732567948;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nRx7B+vn/IKqLeN7//vuxMPJaAva2OfmwM07pIKsra0=;
	b=jB6aellfvD1u7tVXF8mq3Y3RjcURjgug6YVKi5GXPk7DliXdAUKIa+Hs5ilaTpMNTe+Sdi
	iwqocjOKhS9xDaBw==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/Documentation: Update algo in init_size
 description of boot protocol
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241125105005.1616154-1-andriy.shevchenko@linux.intel.com>
References: <20241125105005.1616154-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173256794790.412.16895414786860799051.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     be4ca6c53e66cb275cf0d71f32dac0c4606b9dc0
Gitweb:        https://git.kernel.org/tip/be4ca6c53e66cb275cf0d71f32dac0c4606b9dc0
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Mon, 25 Nov 2024 12:49:14 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 Nov 2024 21:40:56 +01:00

x86/Documentation: Update algo in init_size description of boot protocol

The init_size description of boot protocol has an example of the runtime
start address for the compressed bzImage. For non-relocatable kernel
it relies on the pref_address value (if not 0), but for relocatable case
only pays respect to the load_addres and kernel_alignment, and it is
inaccurate for the latter. Boot loader must consider the pref_address
as the Linux kernel relocates to it before being decompressed as nicely
described in this commit message a year ago:

  43b1d3e68ee7 ("kexec: Allocate kernel above bzImage's pref_address")

Due to this documentation inaccuracy some of the bootloaders (*) made a
mistake in the calculations and if kernel image is big enough, this may
lead to unbootable configurations.

*)
  In particular, kexec-tools missed that and resently got a couple of
  changes which will be part of v2.0.30 release. For the record,
  commit 43b1d3e68ee7 only fixed the kernel kexec implementation and
  also missed to update the init_size description.

While at it, make an example C-like looking as it's done elsewhere in
the document and fix indentation as presribed by the reStructuredText
specifications, so the syntax highliting will work properly.

Fixes: 43b1d3e68ee7 ("kexec: Allocate kernel above bzImage's pref_address")
Fixes: d297366ba692 ("x86: document new bzImage fields")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20241125105005.1616154-1-andriy.shevchenko@linux.intel.com
---
 Documentation/arch/x86/boot.rst | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
index 4fd492c..ad2d8dd 100644
--- a/Documentation/arch/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -896,10 +896,19 @@ Offset/size:	0x260/4
 
   The kernel runtime start address is determined by the following algorithm::
 
-	if (relocatable_kernel)
-	runtime_start = align_up(load_address, kernel_alignment)
-	else
-	runtime_start = pref_address
+   	if (relocatable_kernel) {
+   		if (load_address < pref_address)
+   			load_address = pref_address;
+   		runtime_start = align_up(load_address, kernel_alignment);
+   	} else {
+   		runtime_start = pref_address;
+   	}
+
+Hence the necessary memory window location and size can be estimated by
+a boot loader as::
+
+   	memory_window_start = runtime_start;
+   	memory_window_size = init_size;
 
 ============	===============
 Field name:	handover_offset

