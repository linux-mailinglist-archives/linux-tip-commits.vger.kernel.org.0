Return-Path: <linux-tip-commits+bounces-4119-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1778A5BB83
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Mar 2025 10:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 295AE7A421A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Mar 2025 09:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A8A233140;
	Tue, 11 Mar 2025 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XKujD1+i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VbO4gacL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35C3233120;
	Tue, 11 Mar 2025 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683547; cv=none; b=AZGWBPnCJlRp4FjF8OPMqGTgS/O8jUDtZd9ArCNduXxGn0wobrSF0c7nrOR+EZhxds3PUVc3veGcyK9SR/pqoQ5NdG3qHmBmqwI0YxEvt4yax4dz3Bwl5yCbXv/qVNF0Y4kPbQufCgw8PcOF/9ui3VVNc0lovTEeP+yBVNwuy1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683547; c=relaxed/simple;
	bh=SLkBlr8WxbhFRnNs8blEiqTe/FzSvuvWkdbl0O4mevg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZgXuOK7rsE2dupSxspn4g/J6yW1qLauhnaqlZO8jmcSIs6ufoUNGeNdVEL/snEr1HPAxeP9zkYT1QWwhESKhuLTKgOqSD86UDJzkx0dMDWiKQXms3vIrnXwnGqKYAGSiBq3gJewvUZqLRbnlQNnjTwdGaIDkNzo9rQh/ARjiJXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XKujD1+i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VbO4gacL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Mar 2025 08:58:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741683538;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btK+rN9NFcZdkKMOjkOih9MIKfa79rewTR0kZdyZLTc=;
	b=XKujD1+ivwwrIo9+KZM9gdrNLlQPUxgeB06pZ61ZmuNkn3dYBRfdOTjqYZmFV4v6T5ia+n
	+hwGtatZtvowYZtvh5nZEXT5cVHw/nyFEVISMQEuk5TYPjctryTqG71R+JdU9siW9Cga2R
	vkJEz8is5z3rL4A7kP08BtoKW4IHVx7+MQXIkgZnozxONQ4HxDg9BBMArKssYb8y9MgYNO
	ZVErgNc/1SiJwaNRaSwiimiBajIkBZR1+ALl1l2z6i5bxyAZCwRHf4lknOm18UYTBzlWju
	D30Hd5UCh4q4iNh0lVCPs/DvwZWoTlbqBSoFrD0/dmNBcWAIiGjVHA4UnRCXAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741683538;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btK+rN9NFcZdkKMOjkOih9MIKfa79rewTR0kZdyZLTc=;
	b=VbO4gacL0+097f2IDyIb8IbLR1TJiLn3lxBOqqWnKKnUw/4RhzCgVGqspuDoT4ryXcSRNi
	xQbJKxetii6x6uAA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] x86/vdso: Always reject undefined references
 during linking
Cc: thomas.weissschuh@linutronix.de, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250306-vdso-checkundef-v2-1-a26cc315fd73@linutronix.de>
References: <20250306-vdso-checkundef-v2-1-a26cc315fd73@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174168353285.14745.1972503289964102797.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     c080f2b8a2e44077aed15f1b4f0fbc0f4a912a66
Gitweb:        https://git.kernel.org/tip/c080f2b8a2e44077aed15f1b4f0fbc0f4a9=
12a66
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 06 Mar 2025 15:07:20 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 11 Mar 2025 09:49:15 +01:00

x86/vdso: Always reject undefined references during linking

Instead of using a custom script to detect and fail on undefined
references, use --no-undefined for all VDSO linker invocations.

Drop the now unused checkundef.sh script.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250306-vdso-checkundef-v2-1-a26cc315fd73@li=
nutronix.de
---
 arch/x86/entry/vdso/Makefile      |  7 +++----
 arch/x86/entry/vdso/checkundef.sh | 10 ----------
 2 files changed, 3 insertions(+), 14 deletions(-)
 delete mode 100755 arch/x86/entry/vdso/checkundef.sh

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 1c00723..a6430c5 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -32,7 +32,7 @@ targets +=3D $(foreach x, 64 x32 32, vdso-image-$(x).c vdso=
$(x).so vdso$(x).so.dbg
=20
 CPPFLAGS_vdso.lds +=3D -P -C
=20
-VDSO_LDFLAGS_vdso.lds =3D -m elf_x86_64 -soname linux-vdso.so.1 --no-undefin=
ed \
+VDSO_LDFLAGS_vdso.lds =3D -m elf_x86_64 -soname linux-vdso.so.1 \
 			-z max-page-size=3D4096
=20
 $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
@@ -151,10 +151,9 @@ $(obj)/vdso32.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32=
) FORCE
 quiet_cmd_vdso =3D VDSO    $@
       cmd_vdso =3D $(LD) -o $@ \
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
-		       -T $(filter %.lds,$^) $(filter %.o,$^) && \
-		 sh $(src)/checkundef.sh '$(NM)' '$@'
+		       -T $(filter %.lds,$^) $(filter %.o,$^)
=20
-VDSO_LDFLAGS =3D -shared --hash-style=3Dboth --build-id=3Dsha1 \
+VDSO_LDFLAGS =3D -shared --hash-style=3Dboth --build-id=3Dsha1 --no-undefine=
d \
 	$(call ld-option, --eh-frame-hdr) -Bsymbolic -z noexecstack
=20
 quiet_cmd_vdso_and_check =3D VDSO    $@
diff --git a/arch/x86/entry/vdso/checkundef.sh b/arch/x86/entry/vdso/checkund=
ef.sh
deleted file mode 100755
index 7ee90a9..0000000
--- a/arch/x86/entry/vdso/checkundef.sh
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/sh
-nm=3D"$1"
-file=3D"$2"
-$nm "$file" | grep '^ *U' > /dev/null 2>&1
-if [ $? -eq 1 ]; then
-    exit 0
-else
-    echo "$file: undefined symbols found" >&2
-    exit 1
-fi

