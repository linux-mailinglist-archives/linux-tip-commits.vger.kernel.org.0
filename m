Return-Path: <linux-tip-commits+bounces-2712-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C369B9EA8
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C072824EC
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3F218BB8D;
	Sat,  2 Nov 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dJ55Gjv5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yzcccEml"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C58F189B8F;
	Sat,  2 Nov 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542220; cv=none; b=nFqC0iXz4Yp86+1gdCRCDLKHPF7FU4e7VTPwPWTla10OSDSD+H+MAKCOgvk4fzsZaw6rDHznv0pnKe8RRqFry4EDzy0Ex6+eK7KnUnq2loQ9UHRF0x1Jka2FRkV258ABQQe3dziftiB7a0Zmtqe6URffxbM50+/wmCHvc2Lg09Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542220; c=relaxed/simple;
	bh=MwxOM3Gn6j0FJP2JZ0B0mzFM4SkFmKSsAso5knUJTnI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TtkfovmXPvOHjFpkrufdXClHsAgITc08jyA13vtCNjJAmRN8UiNUizF3QvggoKXYvvinUEG347y9xONsNBAB/g2H9xkjSfki6xzh2eKtySdLaK6yU1NLfLkpyF3ArqSgMvk4tbh3GjWlQfgIah6jTPvf/OZJttIddsCatTstvjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dJ55Gjv5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yzcccEml; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542216;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63DCE6xBoPIPAvd5ClP2Gx8gua08HN/EpaXRtym8r4E=;
	b=dJ55Gjv5N2iIh5vERAYhA8kkWCR/HZlB9HdInfwB6Erazqiy/Z+jEzi4Bmk/6vJyLBP1+2
	RSy+iuxcfdWH+nLD9cY6FYhMHxkTGZBAn6WdWaO2mroE8qDceAWvXe6Fw1jnaqa+9olreX
	Xpjlr5DRJF4Mm+k7N0zT7hxRq3Vibk3A/95yyfA72tP1LBtyvWZ2nmliBbuFXwO6jiy5je
	2AChO01NCfo+GWjibe8uip6asXd7YbLMHmt5MPnpmPaISHqvIYBvCf2Wz90naUtSyO1zZA
	kWmX90fcA3W+pxZlShjvlB6JV9QBIkhHukGGaKaib9GrymV0fVr1ViEnzD+BVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542216;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63DCE6xBoPIPAvd5ClP2Gx8gua08HN/EpaXRtym8r4E=;
	b=yzcccEmlj+GkMivQYvR/2tmEiinUxOsBM89NomaIx23ch4676tmG/4ApAD4DyI10kKOa3b
	sRX1GU2ZzG+oiGAw==
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
Message-ID: <173054221523.3137.10585995506672969020.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     ab19df4553fb6cfc831412c3bca47ef54e56cd24
Gitweb:        https://git.kernel.org/tip/ab19df4553fb6cfc831412c3bca47ef54e5=
6cd24
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:11 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:13 +01:00

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

