Return-Path: <linux-tip-commits+bounces-7824-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF00CF8FE9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 06 Jan 2026 16:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC753305CADE
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Jan 2026 15:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2EC33F8A1;
	Tue,  6 Jan 2026 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVqevqXe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9Qox6n1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A671133DEF2
	for <linux-tip-commits@vger.kernel.org>; Tue,  6 Jan 2026 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712046; cv=none; b=MSBGTpXlEx/8OUoRoXNN0nlZ9qKIvy/4e7i+wlkfSyt9nuiABzXvwbuL0n4lyovM1xYxkQb6zI5jXTKp4JlqEoV3vwr5PXJdzJJhrw2lSrZ1pDYKfyLIUobOx64zO+emsUx6xcrJOtEw4lh42ceUxHiyaHgzAxwYCi21lhxeee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712046; c=relaxed/simple;
	bh=CMjxqxLw/Ci5doH1lPqdeqau4OYfeQieSlVZ2ZdxM50=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t9XR3XiN0TA/NEI4R1m//Y0ZKqQ+q+RZWN31kUdCQvFtwGO132X/aHG/PBo0ffnBPryMeqRnyN6PezNPEbyvXWN+euCNG+rqS6y89wfX/tc83NfQxIc0N6Xbto/JDF7V5kEcjPrs95/FuorPxP3OnQJD9NUpqfJCs6tLz1QPzcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SVqevqXe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B9Qox6n1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767712039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CMjxqxLw/Ci5doH1lPqdeqau4OYfeQieSlVZ2ZdxM50=;
	b=SVqevqXeEzk7fZNNmFnWuI46I+yYtTIMSkkzDhgj6kCKK+gVbNqr5jkTG9PAUqvwpBRv45
	yvw4KYgr9jH9ZUUybHVzW/ISBqpsnyS3SB2LT/sLzt2wktg3bP5qzl/8ms6nZWafn+8J/K
	Zjn9WdcgcM+ED2oPJXqS8obD+lkz4kk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-ZWY_vP0HNNm-08MePKWMTg-1; Tue, 06 Jan 2026 10:07:17 -0500
X-MC-Unique: ZWY_vP0HNNm-08MePKWMTg-1
X-Mimecast-MFC-AGG-ID: ZWY_vP0HNNm-08MePKWMTg_1767712037
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8bb3388703dso431371485a.1
        for <linux-tip-commits@vger.kernel.org>; Tue, 06 Jan 2026 07:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767712037; x=1768316837; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CMjxqxLw/Ci5doH1lPqdeqau4OYfeQieSlVZ2ZdxM50=;
        b=B9Qox6n1Sd9oXuBTuaKPw34Jz0soEZvlwMHCSMDM9bONOa4jMs1smkHypfJE3pemXc
         y194TAbdvQfAb35UPzD6TROHsJeBZOm/E6G/ZJaQaATWBm1ms+hZf8OKaO4FeFpftD6i
         8iqPU1q1Ol4gaW0bhjInvPponZzq1kHsP3utTpC/cMxmli854BL2xhYVOBuapGX/zxxN
         F7zRjsNChG4to7e/rnwOLmpd3c9qCH34LthUr/ealLcgjuY3s+6lqJjZ8SdAd/OaKm9I
         Z/e12C9plWSKO39n9QT9fAYrm5EPmU2fW5ucW+xc5anHYf67edm/t1ztxSBPKnExLWTD
         BOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767712037; x=1768316837;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMjxqxLw/Ci5doH1lPqdeqau4OYfeQieSlVZ2ZdxM50=;
        b=I6ESzyhE0yKchJbCU3/IvHsUJGwBhDf2B7m65Sk0xlzUbCRnJKjKIZQWeOpAiz7/ni
         YrvLWA2qLryExZurbj3h2cLxpVKWMPHZEqSRoEUcIh1AxReMfheaUSw6UI6TxTpMfgqN
         Ls7lEwShuTS9uhKqxX64dMqCNsJgCTQoQ5CFY2K1LzQCPVmYVbcrBDWieSdm9pNed15+
         DkxTOPGPSA/uHCp/PudrrmSXfmoWfzHU+pnnmYkQLiNMxZugdYj15zQaeqJC//wkYXco
         AetSxE3VEzA0On7jXEy7qd6JeuTMu5/6FvYL7Ry5dJaIIYI3VrFzcMOIoMP2aSo+sTql
         tcCA==
X-Forwarded-Encrypted: i=1; AJvYcCVUlzKg9KHB9pVYQq8nH8S3WDaYu+ehbV8LbFYn0C1kQbJouC015ECWCzrKJU13sEwIsBX+JVhXMY/wtHirNXtSEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQWutqZVdMbO78SbdTlsV9mQN0KYu59Tl66F8G4GiNXev2zxng
	amsGaIh81w7BHLexlIOVToaHsKT4R4QJ/xe0+uiGxTmtl6dc8pHc8pBwYRHwsssBbaLOCLqCO87
	PhMpPDDuDG+5x65ftkm7NSnbPobWRJkfEIr8qQFYvitdQSuBIV2lcmaurBaQZDgYQOvaOURMG
X-Gm-Gg: AY/fxX5U6i+XzZMhx5FPTXe0Koonjb/2TGpz9LeB8nCP6hDB3kcA0BvcbF1YasmHV/K
	ZvD5WkJXoIn7qwtdrrFJmBNxgUYdWMl1ibwsWtRG9mEmdwTxRts26AdZFPoqIWDP5MGvQxpWY1r
	894ij1NUUDoP2NTqG4o2ctDR1pLL0I8Gh7niy39yBTtXmnUX0TxSSGq/llOTuSy8Xs+rdsg1r4x
	0Jx+LaKnlalxPQ4XeDzkiCibWiDMKjMIjYXB+cM2W3DkDuoia9mTmWknUxxE//XbEOqm8UQ28ps
	JbeV5sJQfb1UW+LvIBBOvMR7dwyflt8EzzJiSIdyMR7WtKFnMWL5tzKNgtrhIvdJyLHVBmHuEbw
	zvaXKTsm1w9XmzAQGb/yqBBpQ60xtAtC3pfO+b5lhzrk7c3mRmnTtetAWUNQo5S/ww9BpIdRCbY
	E6/A==
X-Received: by 2002:a05:620a:7107:b0:8c3:528b:1b10 with SMTP id af79cd13be357-8c37ebddb4cmr380384385a.90.1767712035410;
        Tue, 06 Jan 2026 07:07:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiDyi2NMxi0Q7EnkMQjTjzMEV1g2tympMDCJWpCiVD6eHjpDWXm78MFa6DFOXzNiCNQZb8pw==
X-Received: by 2002:a05:620a:7107:b0:8c3:528b:1b10 with SMTP id af79cd13be357-8c37ebddb4cmr380362385a.90.1767712033474;
        Tue, 06 Jan 2026 07:07:13 -0800 (PST)
Received: from thinkpad-p1.localdomain (pool-174-112-193-187.cpe.net.cable.rogers.com. [174.112.193.187])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f53129fsm180726485a.44.2026.01.06.07.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:07:13 -0800 (PST)
Message-ID: <9ec6928cd4e7a599d4bbb6ac0258da8997518d3a.camel@redhat.com>
Subject: Re: [tip: irq/msi] PCI: dwc: Enable MSI affinity support
From: Radu Rendec <rrendec@redhat.com>
To: Jon Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
 "linux-tegra@vger.kernel.org"
	 <linux-tegra@vger.kernel.org>
Date: Tue, 06 Jan 2026 10:07:12 -0500
In-Reply-To: <44509520-f29b-4b8a-8986-5eae3e022eb7@nvidia.com>
References: <20251128212055.1409093-4-rrendec@redhat.com>
	 <176583448396.510.10427292538118156779.tip-bot2@tip-bot2>
	 <44509520-f29b-4b8a-8986-5eae3e022eb7@nvidia.com>
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

On Tue, 2026-01-06 at 09:53 +0000, Jon Hunter wrote:
> On 15/12/2025 21:34, tip-bot2 for Radu Rendec wrote:
> > The following commit has been merged into the irq/msi branch of tip:
> >=20
> > Commit-ID:=C2=A0=C2=A0=C2=A0=C2=A0 eaf290c404f7c39f23292e9ce83b8b5b51ab=
598a
> > Gitweb:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://git.kernel.or=
g/tip/eaf290c404f7c39f23292e9ce83b8b5b51ab598a
> > Author:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Radu Rendec <rrendec@=
redhat.com>
> > AuthorDate:=C2=A0=C2=A0=C2=A0 Fri, 28 Nov 2025 16:20:55 -05:00
> > Committer:=C2=A0=C2=A0=C2=A0=C2=A0 Thomas Gleixner <tglx@linutronix.de>
> > CommitterDate: Mon, 15 Dec 2025 22:30:48 +01:00
> >=20
> > PCI: dwc: Enable MSI affinity support
> >=20
> > Leverage the interrupt redirection infrastructure to enable CPU affinit=
y
> > support for MSI interrupts. Since the parent interrupt affinity cannot
> > be changed, affinity control for the child interrupt (MSI) is achieved
> > by redirecting the handler to run in IRQ work context on the target CPU=
.
> >=20
> > This patch was originally prepared by Thomas Gleixner (see Link tag bel=
ow)
> > in a patch series that was never submitted as is, and only parts of tha=
t
> > series have made it upstream so far.
> >=20
> > Originally-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Radu Rendec <rrendec@redhat.com>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Link: https://lore.kernel.org/linux-pci/878qpg4o4t.ffs@tglx/
> > Link: https://patch.msgid.link/20251128212055.1409093-4-rrendec@redhat.=
com
>=20
>=20
> With next-20260105 I am observing the following warning on the Tegra194=
=20
> Jetson AGX platform ...
>=20
> =C2=A0 WARNING KERN genirq: irq_chip DW-PCI-MSI-0001:01:00.0 did not upda=
te
> =C2=A0=C2=A0 eff. affinity mask of irq 171
>=20
> Bisect is point to this commit. This platform is using the driver=20
> drivers/pci/controller/dwc/pcie-tegra194.c. Is there some default=20
> affinity that we should be setting to avoid this warning?

Before that patch, affinity control wasn't even possible for PCI MSIs
exposed by the dw_pci drivers. Without having looked at the code yet,
I suspect it's just because now that affinity control is enabled,
something tries to use it.

I don't think you should set some default affinity. By default, the PCI
MSIs should be affine to all available CPUs, and that warning shouldn't
happen in the first place. Let me test on Jetson AGX and see what's
going on. I'll update the thread with my findings, hopefully later
today.

--=20
Thanks,
Radu


