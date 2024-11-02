Return-Path: <linux-tip-commits+bounces-2725-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BC39B9F8F
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 12:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC5E1F21544
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D36189B88;
	Sat,  2 Nov 2024 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="03377iO5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JFmep9Hi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF42187844;
	Sat,  2 Nov 2024 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548217; cv=none; b=DaY/dBa8z5ejhzwnNuJwH/Z/6dLk6uoTvwH1jv8q50y+xKvQjBWmdNAx3mJrCtIkgUgjzOX73zrdL14ZQhrROdrzYWGgzra+W4BxBvz+aQCfeduNTAozaCjUvyt3nXcIM1v9ZXkftCAnDYGSGx01W5nT7PZhGM2ZB7HyQ2Z04Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548217; c=relaxed/simple;
	bh=Fc7U7053QVlCQp8eZFz6TcgaP56pgbc7AmvhM00HjQY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VkJPgnGeAKCsgplLLH95Vl5fGm3qjm1xqO9j1xXHEXP4r2LZw10gn2CBQpf+tgBd9LqJluV7PnNxMHhUwpe8ZfwRZzRdB7BLpNxkCYtDGYbTVXey8XOZKadTQqvd1CTAzWw9ULzU+J3cQF/OvPNd/a2kX9Hug2jXhjU5XnbukzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=03377iO5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JFmep9Hi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 11:50:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730548214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8dwAeBu5kpoOjVgfJjznHWWOlxk7QJ7KyBHnxdtwyE=;
	b=03377iO5K6LENbOsbu56iJgq75BLo23BJ6gvM8t8d4vS3eiqE6l3MaVE50xtjZS6jXz5NJ
	Ob9hLgD3k3NvnBan/C0J8cwgKKlopZgXopbgIxEZ1SPlBqClJXzysRdHJ+xuYRUVblH7WI
	W1zuE0+7vJQoUhet2uwSy85GEztN2HiN3DawURftdL89ly4Y2a7vGrSj6E36tUoyeU6zsX
	VKVPWQcXdpjV3LWjUCA0vKkMsrE1VMjdQxWfGJSsEr937U8R6+7N1ZxyJzzrkMtntgfenO
	yGUiOrqtRS9gk9RIEYF/YwBowPqX5unoS048hBS+YmgeWQ2G7uvI+XySt7qHhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730548214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8dwAeBu5kpoOjVgfJjznHWWOlxk7QJ7KyBHnxdtwyE=;
	b=JFmep9HiW8JO/c0RRkY8Z00BS9+uDGJsoKe1PS51RXL+co9ugWnfDnN8tTw+UjMiNCOJ4Q
	GrsvPE3xBrvF2jDw==
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
Message-ID: <173054821392.3137.13379406193972004298.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     e07359f171f2440f4dbc98339b10c8c3cdd48a20
Gitweb:        https://git.kernel.org/tip/e07359f171f2440f4dbc98339b10c8c3cdd=
48a20
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 12:37:35 +01:00

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

