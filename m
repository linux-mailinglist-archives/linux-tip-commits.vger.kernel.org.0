Return-Path: <linux-tip-commits+bounces-4120-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AF2A5BBA2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Mar 2025 10:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C523AE22C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Mar 2025 09:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440F42222CB;
	Tue, 11 Mar 2025 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nDJuc/Az";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0wHLy+N3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980021CD205;
	Tue, 11 Mar 2025 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741684178; cv=none; b=gZI69AdavNgYv+wQm3klwQs3VQX17jzElQF0V9ePBpTyK3r0qfrN9+M09NWp32PpGm+Ib2ikijikDB24Jx88XzE7i0Z3bmlTJfM6fqhsqNMoc36XC1PqBnKR/c1cc7EhURWFXqD2wUcfwiSzsuajgCQdyd3V3qF1wH4ClZpnUZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741684178; c=relaxed/simple;
	bh=0flGchsd7b+D+Eonmve3najNNsFRrQsnH8yyHv5ZqaI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JR6LwWh3b21EUbs3pcV+irbN7ybh6mpwEcuWwsD0r8VkTWqlb9HGviT98o8DL/rYXNdEbuORbSuqeMHD1loaQCoqdy0JV0AArc63kaz+Eev18d7BxGt5KhZSM/sNHlVe3xMmc3JLM/2uwmcW9UMn/6SAh5ehYe9Tl4Yy4uScFys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nDJuc/Az; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0wHLy+N3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Mar 2025 09:09:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741684174;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ocwnkJUwj5sdelISdMdqZQ3L4dhRo0bS2D0K9BiAXV8=;
	b=nDJuc/AzPwtSrAt7VQA3/o3Wik5obr8ldjoh7BrlJBWc10dZ8b+A5DN5coRLoia3ZFni4s
	CrO/ykLIIC9m1WO0B/Yoog5Qa3iBZw2QsijDxmiWlCXU4Bf82OuQqlUbcPpXyvRvlUY6nS
	DeNdi+RK6MqbCC8Zl9o+GYchCHCA4edfo7yBAyC2VoNBEgeWrsV+SWGsbRDMr1mGDQ4dQd
	4qaCeViZOGNPYOzVXsosM1Tu4wAoDQ/DsClbbo/xMZc2O+gC+g/c3ac7WUptptL7u95NaC
	9aXgXchpM/QMrmtsb6L4QIj7CeiMPNsZR9Qve2qAwCdbqfBHgk5CFymaHtEUCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741684174;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ocwnkJUwj5sdelISdMdqZQ3L4dhRo0bS2D0K9BiAXV8=;
	b=0wHLy+N3NUB0Y35WXKSUOKVNPm2b+emIDZpldymznCrLVo3IzL2C+fZhorK3J4x07SiRVn
	5AqMLU/eI0ZTL/Bg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] sparc/vdso: Always reject undefined references
 during linking
Cc: thomas.weissschuh@linutronix.de, Ingo Molnar <mingo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250306-vdso-checkundef-v2-2-a26cc315fd73@linutronix.de>
References: <20250306-vdso-checkundef-v2-2-a26cc315fd73@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174168417345.14745.6224882189458073686.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     652262975db421767ada3f05b926854bbb357759
Gitweb:        https://git.kernel.org/tip/652262975db421767ada3f05b926854bbb3=
57759
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 06 Mar 2025 15:07:21 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 11 Mar 2025 09:54:48 +01:00

sparc/vdso: Always reject undefined references during linking

Instead of using a custom script to detect and fail on undefined
references, use --no-undefined for all VDSO linker invocations.

Drop the now unused checkundef.sh script.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Link: https://lore.kernel.org/r/20250306-vdso-checkundef-v2-2-a26cc315fd73@li=
nutronix.de
---
 arch/sparc/vdso/Makefile      |  7 +++----
 arch/sparc/vdso/checkundef.sh | 10 ----------
 2 files changed, 3 insertions(+), 14 deletions(-)
 delete mode 100644 arch/sparc/vdso/checkundef.sh

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 50ec297..fdc4a8f 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -22,7 +22,7 @@ targets +=3D $(foreach x, 32 64, vdso-image-$(x).c vdso$(x)=
.so vdso$(x).so.dbg)
=20
 CPPFLAGS_vdso.lds +=3D -P -C
=20
-VDSO_LDFLAGS_vdso.lds =3D -m elf64_sparc -soname linux-vdso.so.1 --no-undefi=
ned \
+VDSO_LDFLAGS_vdso.lds =3D -m elf64_sparc -soname linux-vdso.so.1 \
 			-z max-page-size=3D8192
=20
 $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
@@ -101,7 +101,6 @@ $(obj)/vdso32.so.dbg: FORCE \
 quiet_cmd_vdso =3D VDSO    $@
       cmd_vdso =3D $(LD) -nostdlib -o $@ \
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
-		       -T $(filter %.lds,$^) $(filter %.o,$^) && \
-		sh $(src)/checkundef.sh '$(OBJDUMP)' '$@'
+		       -T $(filter %.lds,$^) $(filter %.o,$^)
=20
-VDSO_LDFLAGS =3D -shared --hash-style=3Dboth --build-id=3Dsha1 -Bsymbolic
+VDSO_LDFLAGS =3D -shared --hash-style=3Dboth --build-id=3Dsha1 -Bsymbolic --=
no-undefined
diff --git a/arch/sparc/vdso/checkundef.sh b/arch/sparc/vdso/checkundef.sh
deleted file mode 100644
index 2d85876..0000000
--- a/arch/sparc/vdso/checkundef.sh
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/sh
-objdump=3D"$1"
-file=3D"$2"
-$objdump -t "$file" | grep '*UUND*' | grep -v '#scratch' > /dev/null 2>&1
-if [ $? -eq 1 ]; then
-    exit 0
-else
-    echo "$file: undefined symbols found" >&2
-    exit 1
-fi

