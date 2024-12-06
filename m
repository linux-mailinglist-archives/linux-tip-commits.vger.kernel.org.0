Return-Path: <linux-tip-commits+bounces-2995-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB099E6BC4
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 11:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D4916DC8C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 10:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E8E1FF7B9;
	Fri,  6 Dec 2024 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mMOcwh54";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EbcKRawl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BFE1FF612;
	Fri,  6 Dec 2024 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480205; cv=none; b=cY6C09BmT9VBC7CabU7LfRhMqGqMEMloqSPq5vMcVuzA77ESAUclwFTzJ/CZTQvd47CBSuD6Lzp5MjmTEQtCY7KFWofysvf1oSty4ZospQ6lNYvcDyqWCntdzTz5gL0TjxDEvJ9t4PVRTKoYmvzuUsV1p9N/89MOmbZfW3u5e9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480205; c=relaxed/simple;
	bh=ecp/SC2tMvbMZAsHzD96Uy7vEgNZS7rD9w7DUz2Z7wc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kSLgO6bmJWS7IT5xutztKPKnEQcrrrGK3oLEKbrbbzNKhjJB1fhq0GR8SKFEpsShJPEj0O6HOAEtSoIYqT+LkTd1hOTxenVUPHPTUnnoKRzX9yrGARjbCsAir5UUeAxZJIvTTASWSXZXw18rniELUIICt1RfNPNVKTw0aGjdQ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mMOcwh54; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EbcKRawl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Dec 2024 10:16:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733480202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IwPpW/nEk3P8OaBu+3/zdexHxeoO0QnC74uGIp0N0kE=;
	b=mMOcwh54qNlq6d1C/c/5Uwk424EBL/olgaCLAxynf2ZbyXF4hMIQjNVGEi4HryRbKXzzQT
	2nkjigEjBhsH/4rj2gVve/okebn4D0KE8WJ6Eta0+CXZ31ptxNkQ92YghpLSOIfScdQtp2
	OIcI5QQUP/9EehZNbSpe3xGNCDTRGjI3dsMyXsD3BvXeiuumvFXtT/MjDpZC5+kc5jZfju
	75SMulo2JbywZPRfGR+K3Orc9JzQrOg4fZ2qCQdnDUklvVEcFL2VmqKAnmKhnQMTue5AFn
	iJEh/9//t+c23Vcgm0Uw86sYYoD0ChPxE5NEuqLgOeENPHCbWaQMZMAS8rAqfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733480202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IwPpW/nEk3P8OaBu+3/zdexHxeoO0QnC74uGIp0N0kE=;
	b=EbcKRawlnuveVHiRHaBgHtL55NNDgDGIl39ErHdFTMb5EDqO5INa2c1+/aR43R/UlU4ydD
	pRGjwsr3KXFeUYBA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/sysfs: Constify 'struct bin_attribute'
Cc: linux@weissschuh.net, Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20241202-sysfs-const-bin_attr-x86-v1-1-b767d5f0ac5c@weissschuh.net>
References:
 <20241202-sysfs-const-bin_attr-x86-v1-1-b767d5f0ac5c@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173348020189.412.12547674744735426956.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     a3eaa2be7004ed7ce5cf8939c660e44a15fc3665
Gitweb:        https://git.kernel.org/tip/a3eaa2be7004ed7ce5cf8939c660e44a15f=
c3665
Author:        Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
AuthorDate:    Mon, 02 Dec 2024 20:43:24 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Dec 2024 11:06:14 +01:00

x86/sysfs: Constify 'struct bin_attribute'

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241202-sysfs-const-bin_attr-x86-v1-1-b767d5=
f0ac5c@weissschuh.net
---
 arch/x86/kernel/ksysfs.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/ksysfs.c b/arch/x86/kernel/ksysfs.c
index 257892f..b68d4be 100644
--- a/arch/x86/kernel/ksysfs.c
+++ b/arch/x86/kernel/ksysfs.c
@@ -28,19 +28,19 @@ static ssize_t version_show(struct kobject *kobj,
 static struct kobj_attribute boot_params_version_attr =3D __ATTR_RO(version);
=20
 static ssize_t boot_params_data_read(struct file *fp, struct kobject *kobj,
-				     struct bin_attribute *bin_attr,
+				     const struct bin_attribute *bin_attr,
 				     char *buf, loff_t off, size_t count)
 {
 	memcpy(buf, (void *)&boot_params + off, count);
 	return count;
 }
=20
-static struct bin_attribute boot_params_data_attr =3D {
+static const struct bin_attribute boot_params_data_attr =3D {
 	.attr =3D {
 		.name =3D "data",
 		.mode =3D S_IRUGO,
 	},
-	.read =3D boot_params_data_read,
+	.read_new =3D boot_params_data_read,
 	.size =3D sizeof(boot_params),
 };
=20
@@ -49,14 +49,14 @@ static struct attribute *boot_params_version_attrs[] =3D {
 	NULL,
 };
=20
-static struct bin_attribute *boot_params_data_attrs[] =3D {
+static const struct bin_attribute *const boot_params_data_attrs[] =3D {
 	&boot_params_data_attr,
 	NULL,
 };
=20
 static const struct attribute_group boot_params_attr_group =3D {
 	.attrs =3D boot_params_version_attrs,
-	.bin_attrs =3D boot_params_data_attrs,
+	.bin_attrs_new =3D boot_params_data_attrs,
 };
=20
 static int kobj_to_setup_data_nr(struct kobject *kobj, int *nr)
@@ -172,7 +172,7 @@ static ssize_t type_show(struct kobject *kobj,
=20
 static ssize_t setup_data_data_read(struct file *fp,
 				    struct kobject *kobj,
-				    struct bin_attribute *bin_attr,
+				    const struct bin_attribute *bin_attr,
 				    char *buf,
 				    loff_t off, size_t count)
 {
@@ -250,7 +250,7 @@ static struct bin_attribute data_attr __ro_after_init =3D=
 {
 		.name =3D "data",
 		.mode =3D S_IRUGO,
 	},
-	.read =3D setup_data_data_read,
+	.read_new =3D setup_data_data_read,
 };
=20
 static struct attribute *setup_data_type_attrs[] =3D {
@@ -258,14 +258,14 @@ static struct attribute *setup_data_type_attrs[] =3D {
 	NULL,
 };
=20
-static struct bin_attribute *setup_data_data_attrs[] =3D {
+static const struct bin_attribute *const setup_data_data_attrs[] =3D {
 	&data_attr,
 	NULL,
 };
=20
 static const struct attribute_group setup_data_attr_group =3D {
 	.attrs =3D setup_data_type_attrs,
-	.bin_attrs =3D setup_data_data_attrs,
+	.bin_attrs_new =3D setup_data_data_attrs,
 };
=20
 static int __init create_setup_data_node(struct kobject *parent,

