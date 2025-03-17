Return-Path: <linux-tip-commits+bounces-4242-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56903A6490F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91663167894
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF2B14A0A8;
	Mon, 17 Mar 2025 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="azZUoXve"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011EE2E3373;
	Mon, 17 Mar 2025 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206283; cv=none; b=GQS/gNdqW4ffngiU0wIE78qlULg2EHswA9AwUgXOkJ9d/dCa2qHVh/Ju7psbTYW4LtgHgEl0qpTn7JboXLI0EzyW54GA3/EFtMcAJVio6UXJwEbf0qeue8ukbIOaml3P3UKYsmhSn8Lqbghnz1jym7oh0Om+C9qQM0KJcjDrE7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206283; c=relaxed/simple;
	bh=eW/WVR83/G+WjEdhgFrMxyre750EOzwDwu8lMLAJhKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eod6JzRVD9EipZWaDEebG4fGO1tK4EA/rqSgdY4NxNSGh7W86+ZJR1sxQcVhV5mD0cTGlCNb9snhZsw9hfI1yycxD9CHMs8Foy4l6qTGViYtugU9PfP/KuUbkD6V1dQmKetdKpG6y1Fm21Eg+zW8wVRI6e1Hr/3rRA8CcPY+T/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=azZUoXve reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 586A040E021D;
	Mon, 17 Mar 2025 10:11:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id t_qZJD97eXRO; Mon, 17 Mar 2025 10:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742206262; bh=HUpO6KJBEMZfTvE+fpTAFSj4Si4oa0/R/CsTREmzzLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=azZUoXvefM8G9tZJY7DQoTYWoLvljmwsVn/WXp93FNr2xFcUWC4Ql2JK3z8CChk6w
	 kERERBdka7fV6soPc+sum682Mz4hqw1yAYQT51cuwYbrb00u/pYpb6/caluijLufwx
	 KXEFMh4hUf6HtE4JDO3dcPX//WrqJlPncxCCgqeElBvpcTZcBC81OhJjqDHnWMfA1V
	 e1DvbrmWMYaB1hX9nMhXg8NKX1JMIq0gn3Xzz1oXmF954cQSmgYHmtVYbREv3KcOh3
	 9EzCq964gTNA13sBnxj3u2cIUQnK68PfdyRJmBpwww8rLvtttAJ5O7PNarWUyf8/6p
	 iXsxBOjtRnaSObxCVBmHGpRXm8kKUJDyYyQacyMB1ZI3v5aLpV7FE3OBnOBC3DSeNa
	 xnukAdtpDdUMd73wcf90hdhpYWdizG3ZQ+FwmrbfJ2c3XBtaR1PQ2g6X0U/xLBC9/5
	 CiaWjvTVhREa8pThDG6PccF8/7rJE9GXFSZJ3e9xQNt+7W7DMvMhvbcmKf3cBdS8lp
	 4Sn6Es0daDWr4529xnXEBowbLeI1uNOgBtiUyh8iShDbrPX186/MhIixWwDAgcqwNY
	 2dZutHlT2QKJh5pgm4vGNhRCPnbTllknDQO6JH3xB30JkJdiZLzSdybC7qVi42+R1x
	 VMbtrG0/ofDqtPDIA3iEPYQg=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 498F140E0196;
	Mon, 17 Mar 2025 10:10:55 +0000 (UTC)
Date: Mon, 17 Mar 2025 11:10:48 +0100
From: Borislav Petkov <bp@alien8.de>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	Matteo Rizzo <matteorizzo@google.com>,
	Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: perf/urgent] perf/x86: Check data address for IBS software
 filter
Message-ID: <20250317101048.GAZ9f1KEixI3-b0EoR@fat_crate.local>
References: <20250317081058.1794729-1-namhyung@kernel.org>
 <174220290574.14745.9132867025462242568.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <174220290574.14745.9132867025462242568.tip-bot2@tip-bot2>
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 09:15:05AM -0000, tip-bot2 for Namhyung Kim wrote=
:
> The following commit has been merged into the perf/urgent branch of tip=
:
>=20
> Commit-ID:     b0be17d8108bf3448a58be319d085155a128cf3a
> Gitweb:        https://git.kernel.org/tip/b0be17d8108bf3448a58be319d085=
155a128cf3a
> Author:        Namhyung Kim <namhyung@kernel.org>
> AuthorDate:    Mon, 17 Mar 2025 01:10:58 -07:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Mon, 17 Mar 2025 10:04:31 +01:00
>=20
> perf/x86: Check data address for IBS software filter
>=20
> The IBS software filter is filtering kernel samples for regular users i=
n
> PMI handler.  It checks the instruction address in the IBS register to
> determine if it was in the kernel mode or not.
>=20
> But it turns out that it's possible to report a kernel data address eve=
n
> if the instruction address belongs to the user space.  Matteo Rizzo
> found that when an instruction raises an exception, IBS can report some
> kernel data address like IDT while holding the faulting instruction's
> RIP.  To prevent an information leak, it should double check if the dat=
a
> address in PERF_SAMPLE_DATA is in the kernel space as well.
>=20
> Suggested-by: Matteo Rizzo <matteorizzo@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20250317081058.1794729-1-namhyung@kerne=
l.org
> ---
>  arch/x86/events/amd/ibs.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index e7a8b87..24985c7 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -1147,6 +1147,13 @@ fail:
>  	if (perf_ibs =3D=3D &perf_ibs_op)
>  		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data)=
;
> =20
> +	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
> +	    (event->attr.sample_type & PERF_SAMPLE_ADDR) &&
> +	    event->attr.exclude_kernel && !access_ok(data.addr)) {
> +		throttle =3D perf_event_account_interrupt(event);
> +		goto out;
> +	}

Did anyone build this?

arch/x86/events/amd/ibs.c: In function =E2=80=98perf_ibs_handle_irq=E2=80=
=99:
arch/x86/events/amd/ibs.c:1291:63: error: macro "access_ok" requires 2 ar=
guments, but only 1 given
 1291 |             event->attr.exclude_kernel && !access_ok(data.addr)) =
{
      |                                                               ^
In file included from ./arch/x86/include/asm/uaccess.h:25,
                 from ./include/linux/uaccess.h:12,
                 from ./include/linux/sched/task.h:13,
                 from ./include/linux/sched/signal.h:9,
                 from ./include/linux/ptrace.h:7,
                 from ./include/uapi/asm-generic/bpf_perf_event.h:4,
                 from ./arch/x86/include/generated/uapi/asm/bpf_perf_even=
t.h:1,
                 from ./include/uapi/linux/bpf_perf_event.h:11,
                 from ./include/linux/perf_event.h:18,
                 from arch/x86/events/amd/ibs.c:9:
./include/asm-generic/access_ok.h:45: note: macro "access_ok" defined her=
e
   45 | #define access_ok(addr, size) likely(__access_ok(addr, size))
      |=20
arch/x86/events/amd/ibs.c:1291:44: error: =E2=80=98access_ok=E2=80=99 und=
eclared (first use in this function)
 1291 |             event->attr.exclude_kernel && !access_ok(data.addr)) =
{
      |                                            ^~~~~~~~~
arch/x86/events/amd/ibs.c:1291:44: note: each undeclared identifier is re=
ported only once for each function it appears in
make[5]: *** [scripts/Makefile.build:207: arch/x86/events/amd/ibs.o] Erro=
r 1
make[4]: *** [scripts/Makefile.build:465: arch/x86/events/amd] Error 2
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:465: arch/x86/events] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:465: arch/x86] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/mnt/kernel/kernel/6th/linux/Makefile:1997: .] Error 2
make: *** [Makefile:251: __sub-make] Error 2

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

