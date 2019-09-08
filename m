Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 966B9ACB7B
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Sep 2019 10:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfIHIKA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 8 Sep 2019 04:10:00 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36282 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfIHIKA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 8 Sep 2019 04:10:00 -0400
Received: by mail-lj1-f194.google.com with SMTP id l20so9758938ljj.3
        for <linux-tip-commits@vger.kernel.org>; Sun, 08 Sep 2019 01:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rK3idBChgXpZBYEMCk4smWWhaKLMi7X3IKqLIeI2HXw=;
        b=ELop5NzEmw8P2dhvnHe7o1eUrVsiLJI/cSOVdZqbI5Wo2ejzGRFGW3h9c/WvRte4q/
         mHYhwBl9IpsuIaT9p7pUYt/+3+wxzJr3NERGAtY3USrOgzkZGj/rQmgquTme7pRjru16
         u4k8OstlsaHDDw+vP+T2uNAFQ8vD806YJQuy5p/3TR7hBQFig3cec+VhkjkoOhb+uF4+
         kpLRw43nux7w+XVgVyKWwTa1PqAHFQAn1juU7NRxVj+UZz6uI/uDqEEgcXJtxZSTIQu2
         EXcL1Fk+q70zVG4baK4yQdHELKHdf8bgPwc4iOGXgDXH5BzCntFeq79d92I9DHUe90Pm
         zA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rK3idBChgXpZBYEMCk4smWWhaKLMi7X3IKqLIeI2HXw=;
        b=HWv6uMmsWHhf0nBYclFwP9uFLdtbah2Wk/jzJ2CEtvBftlhyKIHEANmKmKqrbLegLV
         tzEFhLPgdv+3qZkLw3aTrsKdi1oBDiblMeCBol6WksGQgNMm8wi+C2VFZ4XxnH+XIxCG
         VsxmNmc6PStC+1Vm3cUOmaOL9vcxZxTDsgNx1dV4tIz3Rf8PVAlfeJKmztlcOjRfeZff
         UU+YqQr/T2oqLJ5/ugP9XUpdhE2P1dRA9ImX5QJWqvVqMlFMVY+dYXsZ/dgGLT9L8qwS
         ea8gLGs76T3DFMx/2G6QzGA+bgFBs4u4LnjOzuEeLYYkObtBkFcYmL3YwFbsdNTHipnB
         Ol8A==
X-Gm-Message-State: APjAAAWU4mYAwDSNvPBKkyXThJ72nDUMhZ2R1FZU4B1CdjqoyXxiVsCK
        1NIipfXuhUDsV6+dnBfaPj37DAeqvf9An4WjZMjM2g==
X-Google-Smtp-Source: APXvYqwQ4r+VRrfjdBn6nVPHnlf3wdFS7wvaHGxSg7UmgOUz8Ir+bHVwQpF3laZCpkO2TkPU4AWjbK20Ax50t3J5XsQ=
X-Received: by 2002:a2e:9dc3:: with SMTP id x3mr7787513ljj.108.1567930198762;
 Sun, 08 Sep 2019 01:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <156776809772.24167.8650737097914479700.tip-bot2@tip-bot2>
In-Reply-To: <156776809772.24167.8650737097914479700.tip-bot2@tip-bot2>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 8 Sep 2019 09:09:47 +0100
Message-ID: <CACRpkdZs9KLaGnU7JrJDviyYwT1PX=pWb5z179t8-XE7ZSGjTA@mail.gmail.com>
Subject: Re: [tip: irq/core] gpio/ixp4xx: Register the base PA instead of its
 VA in fwnode
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Sep 6, 2019 at 12:08 PM tip-bot2 for Marc Zyngier
<tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the irq/core branch of tip:
>
> Commit-ID:     daa19fe5b082779962988a5ba9e38509004db3de
> Gitweb:        https://git.kernel.org/tip/daa19fe5b082779962988a5ba9e38509004db3de
> Author:        Marc Zyngier <maz@kernel.org>
> AuthorDate:    Wed, 31 Jul 2019 16:13:42 +01:00
> Committer:     Marc Zyngier <maz@kernel.org>
> CommitterDate: Wed, 07 Aug 2019 14:24:45 +01:00
>
> gpio/ixp4xx: Register the base PA instead of its VA in fwnode
>
> Do not expose the base VA (it appears in debugfs). Instead,
> record the PA, which at least can be used to precisely identify
> the associated irqchip and domain.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

I think that patch is already in my gpio devel branch.

But I guess it doesn't hurt either, git will figure it out.

Yours,
Linus Walleij
