Return-Path: <linux-tip-commits+bounces-6389-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D333B37DD7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 10:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0C41B61CEF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 08:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7033375AF;
	Wed, 27 Aug 2025 08:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATOAo0ZM"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543783375BE;
	Wed, 27 Aug 2025 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756283348; cv=none; b=DjIvLQxgecxmLSC70ZhSFttTJqYvRmP6C7VM6FILeS34L3QTJ398MpsNnNDl3GzL7kd7lLozqfI192GanmlRl7UfqaeVeBdvUaJNM9S5DP8qmJ/Tss4C56cALMNTvWI3deKJ3FvJLdheIBr283s3eN42/Pa+EM7VJymtzoE8+os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756283348; c=relaxed/simple;
	bh=jJFDqg3W1XpIlbQ+NvdZgxCYXLvPUbQ7azAswu3iDDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=maFMiiryhz2IjGLjgg+mHXGZ+8/fEQwQwxbbPz3SQ42Mta4ZWVyrfUGfRnV+RjFjcZviJyB74vg8dfXPlZrEQNI/Eng6QSd7LSrNuuXsbAoMGw8zYa3XhqjpteSHjSPhnhWvodyraD475GHLX7ZwDcnXUy9bIcCLfdi6vDPK1NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATOAo0ZM; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55ce508d4d6so5313423e87.0;
        Wed, 27 Aug 2025 01:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756283344; x=1756888144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJFDqg3W1XpIlbQ+NvdZgxCYXLvPUbQ7azAswu3iDDU=;
        b=ATOAo0ZMbATAAWThXPtGXYvM3scNDOjwDvxs/SG5aL9TPDUqV20+KyPx2BmoVq1uhl
         MujSg+gVohdEuxEC/2pRZEBhfFoeDrWdqGayFVgQzz3V21y7d6AG8E+1O3/muW6WfR9N
         jnjENqbov5VWdPmYeEeqRdyYxIxNTWXlG32pstTlPOIjMMiq7BvAuZi490JKLTu/Ukn4
         c0oMhIS/XCu2Sw+6DnJIk2FGc6QiVadLY9C1XPoNwPeqDiqOQf11vPz2mcF6cAn2TVfu
         kHzfjq7+avNH5AD3IGshnOBWw/JE2DgUBemkyN+oOUn4BcGRu+bvf2gne7c6Xbe7UfcH
         /Z5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756283344; x=1756888144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJFDqg3W1XpIlbQ+NvdZgxCYXLvPUbQ7azAswu3iDDU=;
        b=CxOA1RGiONj8ODSnkdwBI9b3RY4aqLnanLfbQucTY4yURRFRSW7r5++F1VwAfo1JAf
         YiCXejLAum6wvXiOmMr+s3DbcAd/dOZHww5hisCElah66w9Oc/sTGWGbPZ7IgFu+T9Tr
         7/dnHPSiv9bvJmnB6JK+QNM8AFDS64v3pdRIBNmJ93GJzlnQZalrXCcMzvoT8LWAPkNo
         WW+yQIG3WpVnhKIWsmOEDsVksQq3t4XAPLn7TDKFhKEfw/ObBcfJvBN8uaQEpsZECn2O
         OfGUQrzjdnPduvXWWv9PhWAeoQ5s7H4d68eApl1bK+vebT2icqB9mmDk69Xtw+4Gl7BF
         2l+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfnSZPfOtLniM2ZEy8IoywYmGaSq7hza+WeXeRnJPCJrvKqPbkXrCqBInu5YbEE15JAZovrZkPS/7uS32XhW5dPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhyNRXOA1jmOahWYIwHRQzteAjYbbON3HG4nWFJ7caKhGO0sAu
	3reCzfrSWCoEZQSBNXnrV6pxiDK139b6lFf/2BJVpOU9dl09hDzMTE3o/UTOzS42zwPpRZp0bTm
	wc9KfhFA29Iy500NDahjiqHzSq+qvB8XyIGqk
X-Gm-Gg: ASbGncvrCM7cSA/J9aX4f4tKw5wAUfs6ZBOx0nS7lctkSDGOZo/TUb/2mmjMbOAEnhR
	KOTSZCVk4P8WVDzXJgLfqDc1oPEEXTwAXjsF78PJ4Cd9ozM/ynOKFHWOo4Nc3xN3F5Ru6mvBARQ
	mvU3aeJK8xc0r+0cNcxG1U/TEAXqdytfn2uUbfCJ6I6PGJiUuwnxx3mKZKn6DgYcp7TtqM+EipJ
	E+gGMAcxMlLDLuLZw==
X-Google-Smtp-Source: AGHT+IH2vZsJk2P6q12Hpu7iD7LUO/R96zPmhXjoFed6mZ9+n0ZpEcpsnh0U2/soyKVJyQiyrj3fngvsrSUeOr7O/w4=
X-Received: by 2002:a05:6512:12c4:b0:55f:43ab:b214 with SMTP id
 2adb3069b0e04-55f43abb552mr3462437e87.15.1756283344056; Wed, 27 Aug 2025
 01:29:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616095315.230620-1-ubizjak@gmail.com> <175627714358.1920.14102647257754782558.tip-bot2@tip-bot2>
 <CAFULd4aZYEi02cKeS1RAL66Qs149nLys8SJfTvfHuPH3FMXJeA@mail.gmail.com> <20250827081900.GAaK6_dB-acJ_rkKk4@fat_crate.local>
In-Reply-To: <20250827081900.GAaK6_dB-acJ_rkKk4@fat_crate.local>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 27 Aug 2025 10:28:52 +0200
X-Gm-Features: Ac12FXz0tOCKNvcDKMzf_1OhJZ5v5qrLuZbHPtOpAUnLuK7ZSkY4dlLBmS33J6o
Message-ID: <CAFULd4bEE=HSRhRGgSVik87maNCqV4TcW5q5HHvfgOp1_NwGdw@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/vdso: Fix output operand size of RDPID
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 10:19=E2=80=AFAM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Wed, Aug 27, 2025 at 09:53:17AM +0200, Uros Bizjak wrote:
> > The 1/2 patch is intended to be backportable
>
> Is it fixing an actual, real life bug?

No, because ".byte 0xf3,0x0f,0xc7,0xf8" encodes "RDPID %rax" on 64-bit
targets and we are only interested in the lower 32-bits anyway.

So, the change only matters on the 64-bit target when mnemonic is used
(there is no RDPID %eax" instruction), but the patch should not be
backported for the reasons outlined in my previous message. OTOH, "LSL
%eax,%eax" zero-extends to the full 64-bit register width on 64-bit
targets even when 32-bit register form is used.

Thanks,
Uros.

