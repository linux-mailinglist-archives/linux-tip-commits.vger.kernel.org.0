Return-Path: <linux-tip-commits+bounces-6320-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC85B321CD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 19:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBBB33B7A09
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Aug 2025 17:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56893285C90;
	Fri, 22 Aug 2025 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ewN7plQw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IUtgWqtU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFC635948;
	Fri, 22 Aug 2025 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885214; cv=none; b=RtrfYnrRnqbtL9cbI+SB6eaU4VV942ThSe93fohU4dCxq+inkOL49V90qYM0zlKfO/2XejzedZf6Q5U8X8S/CMkrRcHZPK8fdX3uoyZ0bufbUQZVcqOQjkvvGRpUieGzftVDkeyc69pZ+k00r2IGAznEPrRxNBL82GaPtc7bsIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885214; c=relaxed/simple;
	bh=LNPfbuxp65kSBYykM2M19+7c2/i/YANL70mlWJEHEAI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qkAvjstvLLEBuqkQcRjQohL3Hyr3oAn/T7Rq2AkCUEA0F8MNMtovDfzw6yRqZ9ZrvmE7Fg+QyL55CJi20695jObXX3ySU4kFSutgWSw1D5Vwlh6flFJDtL4JMJ9Z1IoN3YrvEOWydt/cre4fTFsdhNIZzUQ1qG31e+C89yhCj4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ewN7plQw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IUtgWqtU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Aug 2025 17:53:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755885210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FC7Gq5RXBm8dv5x4acIg4brFsqbVyUhtxW2GYba1ouA=;
	b=ewN7plQw/ef2enrhyujsmFD+xRFAjGIXJ8aUa/pd7OtaMG5XMOESeVKQpB7ZlX3H1qmEZD
	UZgKSrrh9nFoaVXPiAAC2aukhKzdPnm93URQvdElohLYufDsS5WULl2UEGPtvadkwXcYTg
	VjXC5w3gr8XwOCJPcp3o7UC/6tTH+yfXT6C91ouhWjNaS/P9dsz95rb6u/5gRce18yYlTj
	Qn07Pte9HJezFyoNC1uMmjo0TwFwi1yWTrE0oIAG3kzLJRWd1kXrxiFSwHTQYLtP2JGTnz
	m61VeZnxlJnaZz9GvRYcLZCgr/6L7pq2ZoBQF1olNDNDOGFudYRuQUPCwM5sPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755885210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FC7Gq5RXBm8dv5x4acIg4brFsqbVyUhtxW2GYba1ouA=;
	b=IUtgWqtUwxy5fmh+yG6ARUntHD3vWsfqWFAAz0U62YdPOJ1Y43JrHMDXBxfXnOSRnvtl7c
	v2c1L1vaQcxttPCw==
From: "tip-bot2 for Thomas Huth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mtrr: Remove license boilerplate text with
 bad FSF address
Cc: Thomas Huth <thuth@redhat.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250801084531.34089-1-thuth@redhat.com>
References: <20250801084531.34089-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175588520901.1420.15964352073642791493.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     045f6a6e4dbaa0ecdee43bc2362676ff62ba5456
Gitweb:        https://git.kernel.org/tip/045f6a6e4dbaa0ecdee43bc2362676ff62b=
a5456
Author:        Thomas Huth <thuth@redhat.com>
AuthorDate:    Fri, 01 Aug 2025 10:45:31 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 22 Aug 2025 19:37:11 +02:00

x86/mtrr: Remove license boilerplate text with bad FSF address

The Free Software Foundation does not reside in "675 Mass Ave, Cambridge"
anymore, so no need to mention that address in the source code here.  But
instead of updating the address to their current location, just drop the
license boilerplate text and use a proper SPDX license identifier instead.  T=
he
text talks about the "GNU *Library* General Public License" and "any later
version", so LGPL-2.0+ is the right choice here.

  [ bp: Massage commit message. ]

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250801084531.34089-1-thuth@redhat.com
---
 arch/x86/include/asm/mtrr.h        | 15 +--------------
 arch/x86/kernel/cpu/mtrr/cleanup.c | 15 +--------------
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 15 +--------------
 3 files changed, 3 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index c69e269..76b95bd 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -1,21 +1,8 @@
+/* SPDX-License-Identifier: LGPL-2.0+ */
 /*  Generic MTRR (Memory Type Range Register) ioctls.
=20
     Copyright (C) 1997-1999  Richard Gooch
=20
-    This library is free software; you can redistribute it and/or
-    modify it under the terms of the GNU Library General Public
-    License as published by the Free Software Foundation; either
-    version 2 of the License, or (at your option) any later version.
-
-    This library is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-    Library General Public License for more details.
-
-    You should have received a copy of the GNU Library General Public
-    License along with this library; if not, write to the Free
-    Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
     Richard Gooch may be reached by email at  rgooch@atnf.csiro.au
     The postal address is:
       Richard Gooch, c/o ATNF, P. O. Box 76, Epping, N.S.W., 2121, Australia.
diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cl=
eanup.c
index 18cf79d..763534d 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: LGPL-2.0+
 /*
  * MTRR (Memory Type Range Register) cleanup
  *
  *  Copyright (C) 2009 Yinghai Lu
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Library General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Library General Public License for more details.
- *
- * You should have received a copy of the GNU Library General Public
- * License along with this library; if not, write to the Free
- * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 #include <linux/init.h>
 #include <linux/pci.h>
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index ecbda03..4b3d492 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: LGPL-2.0+
 /*  Generic MTRR (Memory Type Range Register) driver.
=20
     Copyright (C) 1997-2000  Richard Gooch
     Copyright (c) 2002	     Patrick Mochel
=20
-    This library is free software; you can redistribute it and/or
-    modify it under the terms of the GNU Library General Public
-    License as published by the Free Software Foundation; either
-    version 2 of the License, or (at your option) any later version.
-
-    This library is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-    Library General Public License for more details.
-
-    You should have received a copy of the GNU Library General Public
-    License along with this library; if not, write to the Free
-    Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
     Richard Gooch may be reached by email at  rgooch@atnf.csiro.au
     The postal address is:
       Richard Gooch, c/o ATNF, P. O. Box 76, Epping, N.S.W., 2121, Australia.

