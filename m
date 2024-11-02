Return-Path: <linux-tip-commits+bounces-2698-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3539B9E92
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32AF81F218AF
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58671741D9;
	Sat,  2 Nov 2024 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PVvz+gL4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JI2lbIr9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4893170A19;
	Sat,  2 Nov 2024 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542215; cv=none; b=K3QITp85BR4Em2T0LixgiIixgy7NG8EBHvjzwGsDSWGcxbdRL1mRd5NCfs7OBaZXMU2ND+LdHgkDyf5toeOSrlsMEZW0Gfv7mgSpwbxTKPZWlYrAPvSmp3VZuA1J26zkBjaSTkiuKEUcJrHUTMWfOgeh7yosrYBkPaGELJoeBB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542215; c=relaxed/simple;
	bh=YdNLJ9xm/hbPqoNQt/22NId6TO2CVu+XfgXKNNmtoTs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tKUzu9oEul4mrRa0U/vosD+5DRKFuYaNK+u6lSsbu8nNoMRdmhw6h10ltTCtRVvdz+wYKEk0ZRhepPaLk8oHw0JvmaUtNjBvj10mFdS+rww+sYUX6DK6+rtqFzALgOdOt5JVGas5DjL2j2cekNu+L4QJhmR5EjvoZzZgSnHewsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PVvz+gL4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JI2lbIr9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542205;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FsS0EWcvt4+vT49KmvsNnxLiSBHB12O9/8utWjGv7ag=;
	b=PVvz+gL4xuDd4Ozj+CB2qTM7hdU1UjMFui/dosZYHAF3zmCihpdv7F6wvzfubf30XhtHfn
	czBqAq1+qJ8cT3ATtEUgpAj/4XlfSImvTgar9CNpm+Xa2GKn8XxeHAw44/O/PDmWraXY6T
	xlzoTHQawXWMmt2CtjQj2DNpwKx8RUa1kqrjdConuSujYlGVmPW/RWc9Gvfk9hlz6YUytr
	Oo7vPAanS0Mu51nsehsfbFjoHAgb1gkq05myflivip4LoMqV49lMCskQbvSGm8e40ZoRRe
	WGcJSKrGENiXHoDJd3E2u51g+sZ+BXT2oKktP2tPUi0rpjdmt2qpTEa+PBbosQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542205;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FsS0EWcvt4+vT49KmvsNnxLiSBHB12O9/8utWjGv7ag=;
	b=JI2lbIr9q93A3N9PChFPuQPt4xh71Ai7S3fT42XqvyyKwRinv4HgxyGHZGf+6w8MMv97Ru
	BkuyEAmZEQmIkOCA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] powerpc/pseries/lparcfg: Use num_possible_cpus()
 for potential processors
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-24-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-24-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054220502.3137.14229989700739302201.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     fbedb416fcd6942354008ecbe9ad3a68be888839
Gitweb:        https://git.kernel.org/tip/fbedb416fcd6942354008ecbe9ad3a68be8=
88839
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:15 +01:00

powerpc/pseries/lparcfg: Use num_possible_cpus() for potential processors

The systemcfg processorCount variable tracks currently online variables,
not possible ones, so the stored value is wrong.
The code preferably tries to use the ibm,lrdr-capacity field 4 which
"represents the maximum number of processors that the guest can have."
Switch from processorCount to the better matching num_possible_cpus().

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-24-b64f0842d5=
12@linutronix.de

---
 arch/powerpc/platforms/pseries/lparcfg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platform=
s/pseries/lparcfg.c
index acc640f..cc22924 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -29,7 +29,6 @@
 #include <asm/firmware.h>
 #include <asm/rtas.h>
 #include <asm/time.h>
-#include <asm/vdso_datapage.h>
 #include <asm/vio.h>
 #include <asm/mmu.h>
 #include <asm/machdep.h>
@@ -530,7 +529,7 @@ static int pseries_lparcfg_data(struct seq_file *m, void =
*v)
 		lrdrp =3D of_get_property(rtas_node, "ibm,lrdr-capacity", NULL);
=20
 	if (lrdrp =3D=3D NULL) {
-		partition_potential_processors =3D vdso_data->processorCount;
+		partition_potential_processors =3D num_possible_cpus();
 	} else {
 		partition_potential_processors =3D be32_to_cpup(lrdrp + 4);
 	}

