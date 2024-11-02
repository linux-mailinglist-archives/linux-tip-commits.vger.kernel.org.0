Return-Path: <linux-tip-commits+bounces-2740-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B4D9B9FB3
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 12:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A52282797
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3671AE01D;
	Sat,  2 Nov 2024 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YhRtPtql";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vd8uZFmZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFBE1AC445;
	Sat,  2 Nov 2024 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548228; cv=none; b=ugq7EgI7Plo+dKBbKABJEJtvmuSTDvX94587rJvG9mX8qvKK8ViCIDhmeFnhM8wPCL57sBDiqkaIjCpwXMYe5h6GIGDCJFL8kbrkmRyMk0RggxeaOzEhqRBY+KYXLyS7dm/T5mJJDMqyzd6JDjKQgR7LauT/7LYKLaZXu93OxzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548228; c=relaxed/simple;
	bh=FftummQChmnbw4aFvGlv/6OePQxJ2trF75/TmDq52CU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iBLcf/5Gc/Tn21Q909tOPMjS+S4rvlWNt5Fr9cFNxdkDZmokTA8qCjgNW4ji3X+IhAM+VeBUb2zf1e1WZAVEFoHtdIX6oh5joY0Y0QhXFlhbX7Nvlnl7R7Dg+DWj24fwOleC2ksDl09tB9RNJMdmhS6k29Z8C9V0zyQqH57WS40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YhRtPtql; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vd8uZFmZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 11:50:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730548226;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6qY5sBQs2RUZbrAezf6DAf81U8hrDAd4qt3ImM17a4=;
	b=YhRtPtqlw6PsPhjvtDDH+mO+grIua1VeGzoiK1NEVtxuW8ZJiCW44wc9u8tKMYxnSnU8Yv
	5MhCXu4WeVaZql3ZenKbHM+6H+X+NTBJ+9Xu4XJPeaIjHHa6hRijvZYnXv50ekLaEMpCfC
	+YIfeKbjdBlohd0NrZ2uuzRD228qQNizRQteGXI/vHsUi5Ei6yl59bHYs9c8R3kpDP05aX
	b1QYr0ov5/Ifuhi53JEffh6KG9dVdL/9HcC0p0OllFksiN5pab6kOmM6gWySwqfKuj7Mb3
	NnhaErwLbNrXYD2Jc2PYDCtEu9rm08ZJCMn/ljM4mYAcvU01YTaZ6N2v7IzIuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730548226;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6qY5sBQs2RUZbrAezf6DAf81U8hrDAd4qt3ImM17a4=;
	b=vd8uZFmZQK2TFT9mR+eICKTFkLsNe/PacIsuxU5p1uRfs1C4OUnXxWoboOve6SwJHYmsxs
	AefgSacBQtH43OCA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] MIPS: vdso: Avoid name conflict around "vdso_data"
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-9-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-9-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054822509.3137.5234419151756841782.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     c9b5482d0e726826034fd6e2302d7458e685d2cb
Gitweb:        https://git.kernel.org/tip/c9b5482d0e726826034fd6e2302d7458e68=
5d2cb
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:11 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 12:37:33 +01:00

MIPS: vdso: Avoid name conflict around "vdso_data"

The generic vdso/datapage.h declares a symbol named "vdso_data".
Avoid a conflict by renaming the identically named variable in genvdso.c.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-9-b64f0842d51=
2@linutronix.de

---
 arch/mips/vdso/genvdso.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/vdso/genvdso.c b/arch/mips/vdso/genvdso.c
index 09e30eb..d47412e 100644
--- a/arch/mips/vdso/genvdso.c
+++ b/arch/mips/vdso/genvdso.c
@@ -270,7 +270,7 @@ int main(int argc, char **argv)
=20
 	/* Write out the stripped VDSO data. */
 	fprintf(out_file,
-		"static unsigned char vdso_data[PAGE_ALIGN(%zu)] __page_aligned_data =3D {=
\n\t",
+		"static unsigned char vdso_image_data[PAGE_ALIGN(%zu)] __page_aligned_data=
 =3D {\n\t",
 		vdso_size);
 	for (i =3D 0; i < vdso_size; i++) {
 		if (!(i % 10))
@@ -286,7 +286,7 @@ int main(int argc, char **argv)
=20
 	fprintf(out_file, "struct mips_vdso_image vdso_image%s%s =3D {\n",
 		(vdso_name[0]) ? "_" : "", vdso_name);
-	fprintf(out_file, "\t.data =3D vdso_data,\n");
+	fprintf(out_file, "\t.data =3D vdso_image_data,\n");
 	fprintf(out_file, "\t.size =3D PAGE_ALIGN(%zu),\n", vdso_size);
 	fprintf(out_file, "\t.mapping =3D {\n");
 	fprintf(out_file, "\t\t.name =3D \"[vdso]\",\n");

