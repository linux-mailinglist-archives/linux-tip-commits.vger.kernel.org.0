Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C481F6A21
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Jun 2020 16:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgFKOfg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 11 Jun 2020 10:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbgFKOfd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 11 Jun 2020 10:35:33 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A612EC08C5C2
        for <linux-tip-commits@vger.kernel.org>; Thu, 11 Jun 2020 07:35:31 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id n23so7153501ljh.7
        for <linux-tip-commits@vger.kernel.org>; Thu, 11 Jun 2020 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KWk0k65t0kOficvgdudXMmddBkNR1PEPUz9kdhfi4Ks=;
        b=H+m1ObQ8oA3mUjWkoURr+qG3kfHMQzxTcPyrFKEeKFLi6uzC/t9Hui5UZJJxG08xH6
         7rVdxBgDpCFUOJtSUKhIraQlbkRCokMmbht3vVYFAapq1COXAdtnr1PRIgkBrbYmlc1A
         Q077llttOxRstZhQXqv+DFJlQLw6Mi9WfCdhbL88BGeNx1D2I5qk17f6LkYZNXEr6LQD
         yde6uy2zS8EgnuXvCsCR2rxzDu/YqFDvDZHK1mN/ky43mZNJsFtLzzH7l/GXX7K1Veqj
         gq7LpoEZk8Hy3Fwcq5sivLjtdusU0/gbcevZ21LB6tTmHTE2ro17OEwx2Ve63dfzvVVL
         N1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWk0k65t0kOficvgdudXMmddBkNR1PEPUz9kdhfi4Ks=;
        b=cP2ozyQk60TOYuqb4zGlWUrd99h44cvj3sQDxmcKWWhtcfNu4tcAGsNVrX/gqRXS4v
         /ueyuHxwMQGh25qlDN0VIgV2xXug398Mfwmf6knvvOAymqf3dHGmLkUV5EGvQooVXzVO
         91pJ/x9HmBnudAjpii2VV1errub8Tf+jTZHJf+tdHVFb4/x7jDOVHDPWZ60Hu5zXSx8A
         kSflt87EAmJfAIqk8RGuRL7jELar9jaDnB16ygzq7JItjZX6iIB8F1QEGZBoh66fvuxr
         R4rzlOW+1dkpRdoxUvtgUHvCtxs2CMBJW8heDg0uIg0+GKO5jraXoIj8aV0jcCAu/oxM
         GVbg==
X-Gm-Message-State: AOAM532G891ZwEoL+sKxrISiPuWhOv5K8pv+LR/bz2VzCxr0AHsG/uek
        rso50bGhAxFilH76MmifhAfap64s0+J0Mq0fcJ/SbC9Z5Q==
X-Google-Smtp-Source: ABdhPJybuCvUjX/x8Ef8beUk/vAnwQAMrkhFzQY6QulcBSIDD6yCU7He7Vh09xpStp55hBURCug01ltnDXo7IhR0q74=
X-Received: by 2002:a2e:974e:: with SMTP id f14mr4390482ljj.102.1591886129560;
 Thu, 11 Jun 2020 07:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <159169282952.17951.3529693809120577424.tip-bot2@tip-bot2> <20200611140951.GD30352@zn.tnic>
In-Reply-To: <20200611140951.GD30352@zn.tnic>
From:   Anthony Steinhauser <asteinhauser@google.com>
Date:   Thu, 11 Jun 2020 07:35:18 -0700
Message-ID: <CAN_oZf16odNhpY6_LqkVY2wpy90jKM9-vgKo4LE8OJ-QTDCKiw@mail.gmail.com>
Subject: Re: [tip: x86/urgent] x86/speculation: Avoid force-disabling IBPB
 based on STIBP and enhanced IBRS.
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Hi Borislav,

On Thu, Jun 11, 2020 at 7:09 AM Borislav Petkov <bp@alien8.de> wrote:
>
> Can we merge this test into the one above? Diff ontop:

Yes, I think it's fine.

> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
