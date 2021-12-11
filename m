Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A964711BA
	for <lists+linux-tip-commits@lfdr.de>; Sat, 11 Dec 2021 06:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhLKF2Q (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 11 Dec 2021 00:28:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22932 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229452AbhLKF2P (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 11 Dec 2021 00:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639200279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vEoBWvfKJezafb/gz8qOuM9H17UzU01X5cgIQsGVem0=;
        b=g38RIPNRIIERqejUcUz8eO8ZxIBvz41lZF5M/MJXch61UD1r/OjtAHde3ThbIeto4FRVo7
        Bh6snzpclDjN6/An5G1d1ikHPyWCa14Ty1EmD156iGRvjaDEcq+atJtvphPC1UNCgDscfH
        MF+JVfMn+VkkhoP7a8e552BcTg+PYR0=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-5RTM5UojPUe2fSqLJSXEnw-1; Sat, 11 Dec 2021 00:24:37 -0500
X-MC-Unique: 5RTM5UojPUe2fSqLJSXEnw-1
Received: by mail-ua1-f71.google.com with SMTP id 106-20020a9f2473000000b002d0671b34efso7734394uaq.10
        for <linux-tip-commits@vger.kernel.org>; Fri, 10 Dec 2021 21:24:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vEoBWvfKJezafb/gz8qOuM9H17UzU01X5cgIQsGVem0=;
        b=D9rynOARqO9rK/nhqNQixEOOcEr+ZQSIDqKbsmhHVX51Yf5erDyBGB/Vs/gnWL4O95
         xt6nJwRBwljMYWQjpvjRYlUCZW8ewoPfn1OQlXnAd0ij9Cv9GimTSp+kjs50O+uhK/ts
         nGXU6MYvkAB0Gv9X8xU4UyjZiTsRwF9atPyB9+0fcsMdcy2bZsQ5GBK8sXM8pKlp0cPP
         MHsCyKd0o8Y9Gk21bab9u9fytPdpfT2NiA7Api+FaErWhe+ku59CRAexZ4maNKyuoRyu
         XPVsXn8vkUBSsAzCwsJBJCVXGm35ioxWyNL5/PvRgX7kyv+2rdYl3NrR5OErbKOz02Bx
         TW1w==
X-Gm-Message-State: AOAM533T7IvFpfIlBplW0kaG5pPP530DeWY20ussdzZJhfWCABBc16B2
        PzkzS9c4oarkS28H4WhDudGoWsvRs5B8A//UUUi66YC4yCV1Wm51JrRuoF7qghNbEChiq6yMda1
        a5F2hhx5Qv+aqlRe1FlT4fOzDdTpBlLBEHRS8OhvrVg/w4zw=
X-Received: by 2002:a05:6102:2910:: with SMTP id cz16mr21266823vsb.9.1639200277283;
        Fri, 10 Dec 2021 21:24:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyYuTo+cFn0Ym+OeF+CcyKc83VT49otL8gLNPTOMiwVV425TmLj+Cp1WxDVtcutyVADxYR1xNwNuwfmYUW4Meo=
X-Received: by 2002:a05:6102:2910:: with SMTP id cz16mr21266819vsb.9.1639200277130;
 Fri, 10 Dec 2021 21:24:37 -0800 (PST)
MIME-Version: 1.0
References: <163697618022.414.12673958553611696646.tip-bot2@tip-bot2>
 <20211209143810.452527-1-jdorminy@redhat.com> <YbIeYIM6JEBgO3tG@zn.tnic>
 <50f25412-d616-1cc6-f07f-a29d80b4bd3b@suse.com> <YbIgsO/7oQW9h6wv@zn.tnic>
 <YbIu55LZKoK3IVaF@kernel.org> <YbIw1nUYJ3KlkjJQ@zn.tnic> <YbM5yR+Hy+kwmMFU@zn.tnic>
In-Reply-To: <YbM5yR+Hy+kwmMFU@zn.tnic>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Sat, 11 Dec 2021 00:24:25 -0500
Message-ID: <CAMeeMh9DVNJC+Q1HSB+DJzy_YKto=j=3iGUiCgseqmx9qjVCUg@mail.gmail.com>
Subject: Re: [tip: x86/urgent] x86/boot: Pull up cmdline preparation and early
 param parsing
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mike Rapoport <rppt@kernel.org>, Juergen Gross <jgross@suse.com>,
        tip-bot2@linutronix.de, anjaneya.chagam@intel.com,
        dan.j.williams@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org, stable@vger.kernel.org,
        x86@kernel.org, Hugh Dickins <hughd@google.com>,
        "Patrick J. Volkerding" <volkerdi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Apologies for delay; my dev machine was broken much of today. But I
have tested this patch under the same conditions as previously, and
agree with Hugh that the patches make mem= work correctly.

Thanks!

John Dorminy

