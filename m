Return-Path: <linux-tip-commits+bounces-7828-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0358CFB901
	for <lists+linux-tip-commits@lfdr.de>; Wed, 07 Jan 2026 02:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6B55307269F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Jan 2026 01:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D7D285C8D;
	Wed,  7 Jan 2026 01:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/K+h/bg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBdvF3+r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B82728506C
	for <linux-tip-commits@vger.kernel.org>; Wed,  7 Jan 2026 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767748424; cv=none; b=Zq13HJh6puR7RloRLz+Ij8V8/qm6jb7zMq8kRHJLIfp5czWgcdoESfDcMT0QsHUQHRAnAEJsB9ByGOLSBayZA1r03Lw7hWEmGt7Xms4AaGvU6vWJW3v/uR5HEnm6HEbx0Iz2RtHHBx2RRbsydxhqbfUN+1BiNO9NNQ/i3IWklkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767748424; c=relaxed/simple;
	bh=Rl+RVB635jDWTyz3WbQdh8xirqGQS1j4dySJG+WcogQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZNFDfcmhaLi4VpZ2hQSKY6ZBwFrdtB4E969siei5hKQyuJnF6kds3tjT1vGfNFLJ+cNxqkpNNU5S/KEkEW3KhQFtaPmPogaqYzQEPtR4WbkOKpW10Mz7I40Mz7xbgTccGrNDmuI6xAup7UGe0gEld8fe+wHXJFT2SSnUSr4oPEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P/K+h/bg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBdvF3+r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767748421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGEm6SrfIkQBXCBDJsmfWgmej6ZHwdAiFj4oBQ8yV/4=;
	b=P/K+h/bg3Vkj60zDX2eaesPEo8r4ZgYpGS28YZqI9QBOlGbRNx40CZ5J+bgcIE/AnTSqPQ
	64e4hl+BbRKhxPnPqpPylHm8kw+vNaThJzPoieg+rPMc/BtmCM60T05b8BWrCxgSY54moP
	59WlHbIoogTjGZyBhlHdis1fBDF4xDM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-UGRQzFc0OpyiuDdCBG1Z4A-1; Tue, 06 Jan 2026 20:13:38 -0500
X-MC-Unique: UGRQzFc0OpyiuDdCBG1Z4A-1
X-Mimecast-MFC-AGG-ID: UGRQzFc0OpyiuDdCBG1Z4A_1767748418
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f1dea13d34so36595811cf.1
        for <linux-tip-commits@vger.kernel.org>; Tue, 06 Jan 2026 17:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767748418; x=1768353218; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jGEm6SrfIkQBXCBDJsmfWgmej6ZHwdAiFj4oBQ8yV/4=;
        b=PBdvF3+rC8a6QbF17pOkEP74ZCpb0RqbvqNs6X1+S1ntZyf2QhFb1UHXSef5FNb1M4
         nUXnJrGWLocTqz5KdkdLo/0TBiwyTTffhI8hcQUGIiF0Nze1y8+jCz0T2hHhAEk6rMR1
         lCAmA09jJBIP0DZ6Boef1FooNDsmBOpjC7Uz65hoAUs6cnvn/myrw5K5dw1GAsjEjNCf
         cFR+a7Lrx/NP8PGd8MZJyb2Wi1bGimZ8fOWRK30wzI6LtAz59/AtufBIoU2mzq5f5Rdy
         UU12GV0IYSIl9QDVa3A6ivli/y+qrH9c/FHnlE7dENu6iDcIBl+G3Ay8McUeMC4W/mYS
         4Bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767748418; x=1768353218;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGEm6SrfIkQBXCBDJsmfWgmej6ZHwdAiFj4oBQ8yV/4=;
        b=thWpkCK8ro+/otfAdtHtfeGKr+HgRolKrzkH3dsXCmgizbXeAuVWRYmUT0zBkOwcdL
         E1CeniwdoC34DpHaJkrt1DpuFN/0AKgpunLfWJ3IO+nG7/IfiQi9dVKpPEW4C32b5+1p
         AkxexKGBM4uT4K4PRq9PDlgaWKhyZEMTkxmKjV5mXEcr4Ygj++T2IuDSMoCzP1re63V2
         7JXKrSdaelM7HL8PZXtUtaLsIOGkzFsZRwVy0J1MXGjlmRjWXynenMb5Yv7oQUN5cO0h
         P+umQ2vlNvLFbD33VlCqOq5vfna6bODik9vb0smgKKkmJ48jEKDSU5PJqLIzeusYkYzC
         bwAw==
X-Forwarded-Encrypted: i=1; AJvYcCUuJHVVN93ylg9d7OryVN5iCUA7lswOejLQeKX/r1qy5tJq+eImy9XwHrHAMGyNWsZzR9wO4oNFSaBV0mQlIMXozg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm4Aae8Z6hnXpu3J+M7FWZvCkWoKiir8EpQAaYWU0IHrdKTOZG
	LPIOVxqjNdGlgTya5BEn5FN/ogDoZCurlBZ3SK3smknq3At5f5N9PdokFKRWB5FLZ4DelupuILD
	UeWY05glHYr1PxFnw/lqsykRs1VKUYBkjmKWPpPEGnBfZQqJ1Lk8XbLYt/FdL3bypiAgV/Giz
X-Gm-Gg: AY/fxX47M09I9Y8nQc6Zq1rmPnqHod7hpqzBknzwZNVwuy/8c7zRq7lkmguLHeVKg1f
	r6yAW7bU1oEL+tSQ5Tor71ksqEaENkt2fxI8zOZ1MO+Y7nLS70emg3GUkp+Q6g+XT1E4f1jIfZz
	QSO2XdAtlssbj5ItVW9NC1mX3vTo0IqwtGTZ8Tf2KLMSRZhO5mH7lFZ48bDrufvKfoNvGm+OrF1
	TdjhTX8lduhNTYNpe1AWaE8cloQjmUuEOM2ZZfPBlwBBUBbZ+44W5J3ytMmnwCcOlTWU9cxKQnK
	8G5E6nktCCsxJurrHXXfMUSgFxJKKj0zDSvW6BFkfSGFy0AQiQPuRnldgFQGhOhBbGlTTfmj8As
	47dlffa4G1DM4yzVF46+AA3YfFzZQEDnWIpQLHic9ofQVMwmJdXJLtBgInCecYGnDQX2zsjFpwB
	tWZQ==
X-Received: by 2002:ac8:5810:0:b0:4eb:a192:de99 with SMTP id d75a77b69052e-4ffb4ab80d3mr11772951cf.76.1767748418074;
        Tue, 06 Jan 2026 17:13:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFv+apa0jRruNJjdM2l53yEuFK4YAhqutLPAPVUGPuZp1HG97C4J0qur49aGEfGm4e3uR+Xw==
X-Received: by 2002:ac8:5810:0:b0:4eb:a192:de99 with SMTP id d75a77b69052e-4ffb4ab80d3mr11772701cf.76.1767748417656;
        Tue, 06 Jan 2026 17:13:37 -0800 (PST)
Received: from thinkpad-p1.localdomain (pool-174-112-193-187.cpe.net.cable.rogers.com. [174.112.193.187])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffb75d7916sm566541cf.7.2026.01.06.17.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 17:13:37 -0800 (PST)
Message-ID: <144a39f2d19af30961498acc11d6b7475166ccf5.camel@redhat.com>
Subject: Re: [tip: irq/msi] PCI: dwc: Enable MSI affinity support
From: Radu Rendec <rrendec@redhat.com>
To: Jon Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
 "linux-tegra@vger.kernel.org"
	 <linux-tegra@vger.kernel.org>
Date: Tue, 06 Jan 2026 20:13:36 -0500
In-Reply-To: <9ec6928cd4e7a599d4bbb6ac0258da8997518d3a.camel@redhat.com>
References: <20251128212055.1409093-4-rrendec@redhat.com>
		 <176583448396.510.10427292538118156779.tip-bot2@tip-bot2>
		 <44509520-f29b-4b8a-8986-5eae3e022eb7@nvidia.com>
	 <9ec6928cd4e7a599d4bbb6ac0258da8997518d3a.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jon,

On Tue, 2026-01-06 at 10:07 -0500, Radu Rendec wrote:
> On Tue, 2026-01-06 at 09:53 +0000, Jon Hunter wrote:
> > On 15/12/2025 21:34, tip-bot2 for Radu Rendec wrote:
> > > The following commit has been merged into the irq/msi branch of tip:
> > >=20
> > > Commit-ID:=C2=A0=C2=A0=C2=A0=C2=A0 eaf290c404f7c39f23292e9ce83b8b5b51=
ab598a
> > > Gitweb:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://git.kernel.=
org/tip/eaf290c404f7c39f23292e9ce83b8b5b51ab598a
> > > Author:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Radu Rendec <rrende=
c@redhat.com>
> > > AuthorDate:=C2=A0=C2=A0=C2=A0 Fri, 28 Nov 2025 16:20:55 -05:00
> > > Committer:=C2=A0=C2=A0=C2=A0=C2=A0 Thomas Gleixner <tglx@linutronix.d=
e>
> > > CommitterDate: Mon, 15 Dec 2025 22:30:48 +01:00
> > >=20
> > > PCI: dwc: Enable MSI affinity support
> > >=20
> > > Leverage the interrupt redirection infrastructure to enable CPU affin=
ity
> > > support for MSI interrupts. Since the parent interrupt affinity canno=
t
> > > be changed, affinity control for the child interrupt (MSI) is achieve=
d
> > > by redirecting the handler to run in IRQ work context on the target C=
PU.
> > >=20
> > > This patch was originally prepared by Thomas Gleixner (see Link tag b=
elow)
> > > in a patch series that was never submitted as is, and only parts of t=
hat
> > > series have made it upstream so far.
> > >=20
> > > Originally-by: Thomas Gleixner <tglx@linutronix.de>
> > > Signed-off-by: Radu Rendec <rrendec@redhat.com>
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > Link: https://lore.kernel.org/linux-pci/878qpg4o4t.ffs@tglx/
> > > Link: https://patch.msgid.link/20251128212055.1409093-4-rrendec@redha=
t.com
> >=20
> >=20
> > With next-20260105 I am observing the following warning on the Tegra194=
=20
> > Jetson AGX platform ...
> >=20
> > =C2=A0 WARNING KERN genirq: irq_chip DW-PCI-MSI-0001:01:00.0 did not up=
date
> > =C2=A0=C2=A0 eff. affinity mask of irq 171
> >=20
> > Bisect is point to this commit. This platform is using the driver=20
> > drivers/pci/controller/dwc/pcie-tegra194.c. Is there some default=20
> > affinity that we should be setting to avoid this warning?
>=20
> Before that patch, affinity control wasn't even possible for PCI MSIs
> exposed by the dw_pci drivers. Without having looked at the code yet,
> I suspect it's just because now that affinity control is enabled,
> something tries to use it.
>=20
> I don't think you should set some default affinity. By default, the PCI
> MSIs should be affine to all available CPUs, and that warning shouldn't
> happen in the first place. Let me test on Jetson AGX and see what's
> going on. I'll update the thread with my findings, hopefully later
> today.

I looked at the code and tested, and the problem is that the effective
affinity mask is not updated for interrupt redirection. The bug is not
in this patch, but the previous one in the series [1], which adds the
interrupt redirection framework.

The warning is actually triggered when the MSI is set up. This is the
top part of the relevant stack trace:
  irq_do_set_affinity+0x28c/0x300 (P)
  irq_setup_affinity+0x130/0x208
  irq_startup+0x118/0x170
  __setup_irq+0x5b0/0x6a0
  request_threaded_irq+0xb8/0x180
  devm_request_threaded_irq+0x88/0x150
  rtw_pci_probe+0x1e8/0x370 [rtw88_pci]

I don't immediately see an easy way to fix it for the generic case
because the affinity of the=C2=A0demultiplexing IRQ (the "parent" IRQ) can
change after the affinity of the demultiplexed IRQ (the "child" IRQ)
has been set up. But since dw_pcie is currently the only user of the
interrupt redirection infrastructure, and it sets up the demultiplexing
IRQ as a chained IRQ, there is no way its affinity can change other
than CPU hot(un)plug. And in this particular case, something as simple
as will work:

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index d5c3f6ee24cc2..036641f9534ae 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1512,8 +1512,11 @@ EXPORT_SYMBOL_GPL(irq_chip_release_resources_parent)=
;
 int irq_chip_redirect_set_affinity(struct irq_data *data, const struct cpu=
mask *dest, bool force)
 {
 	struct irq_redirect *redir =3D &irq_data_to_desc(data)->redirect;
+	unsigned int target_cpu =3D cpumask_first(dest);
+
+	WRITE_ONCE(redir->target_cpu, target_cpu);
+	irq_data_update_effective_affinity(data, cpumask_of(target_cpu));
=20
-	WRITE_ONCE(redir->target_cpu, cpumask_first(dest));
 	return IRQ_SET_MASK_OK;
 }
 EXPORT_SYMBOL_GPL(irq_chip_redirect_set_affinity);

I will send this as a proper patch tomorrow, and it will fix the
immediate problem and buy some time for a more elaborate fix for the
generic case. Meanwhile, thanks a lot for finding/reporting this!

[1] https://lore.kernel.org/all/20251128212055.1409093-2-rrendec@redhat.com=
/

--=20
Best regards,
Radu


